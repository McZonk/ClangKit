/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CKDiagnostic+Private.h"
#import "CKSourceLocation.h"

@implementation CKDiagnostic( Private )

- ( id )initWithCXDiagnostic: ( CXDiagnostic )diagnostic
{
    CXString string;
    CXString spelling;
    
    if( ( self = [ self init ] ) )
    {
        _cxDiagnostic = diagnostic;
        string        = clang_formatDiagnostic( _cxDiagnostic, clang_defaultDiagnosticDisplayOptions() );
        spelling      = clang_getDiagnosticSpelling( _cxDiagnostic );
        _string       = [ [NSString alloc ] initWithCString: clang_getCString( string ) encoding: NSUTF8StringEncoding ];
        _spelling     = [ [NSString alloc ] initWithCString: clang_getCString( spelling ) encoding: NSUTF8StringEncoding ];
        _severity     = ( CKDiagnosticSeverity )clang_getDiagnosticSeverity( _cxDiagnostic );
        _location     = [ [ CKSourceLocation alloc ] initWithDiagnostic: self ];
        
        clang_disposeString( string );
        clang_disposeString( spelling );
    }
    
    return self;
}

@end
