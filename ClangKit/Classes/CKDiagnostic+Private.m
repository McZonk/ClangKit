/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CKDiagnostic+Private.h"
#import "CKTranslationUnit.h"
#import "CKFixIt.h"

@implementation CKDiagnostic( Private )

- ( id )initWithCXDiagnostic: ( CXDiagnostic )diagnostic translationUnit: ( CKTranslationUnit * )translationUnit
{
    CXString         string;
    CXString         spelling;
    CXSourceLocation location;
    CXSourceRange    range;
    unsigned int     line;
    unsigned int     column;
    unsigned int     offset;
    
    if( ( self = [ self init ] ) )
    {
        _cxDiagnostic = diagnostic;
        string        = clang_formatDiagnostic( _cxDiagnostic, clang_defaultDiagnosticDisplayOptions() );
        spelling      = clang_getDiagnosticSpelling( _cxDiagnostic );
        _string       = [ [NSString alloc ] initWithCString: clang_getCString( string ) encoding: NSUTF8StringEncoding ];
        _spelling     = [ [NSString alloc ] initWithCString: clang_getCString( spelling ) encoding: NSUTF8StringEncoding ];
        _severity     = ( CKDiagnosticSeverity )clang_getDiagnosticSeverity( _cxDiagnostic );
        
        clang_disposeString( string );
        clang_disposeString( spelling );
        
        location  = clang_getDiagnosticLocation( diagnostic );
        range     = clang_getDiagnosticRange( diagnostic, 0 );
                
        clang_getExpansionLocation( location, translationUnit.cxFile, &line, &column, &offset );
        
        _line   = ( NSUInteger )line;
        _column = ( NSUInteger )column;
        _range  = NSMakeRange( ( NSUInteger )offset, range.end_int_data - range.begin_int_data );
        
        _fixIts = [ [ CKFixIt fixItsForDiagnostic: self ] retain ];
    }
    
    return self;
}

@end
