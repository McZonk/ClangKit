/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CKToken+Private.h"
#import "CKTranslationUnit.h"

@implementation CKToken( Private )

- ( id )initWithCXToken: ( CXToken )token translationUnit: ( CKTranslationUnit * )translationUnit
{
    CXString         spelling;
    CXSourceRange    range;
    CXSourceLocation location;
    unsigned int     line;
    unsigned int     column;
    unsigned int     offset;
    
    if( ( self = [ self init ] ) )
    {
        spelling  = clang_getTokenSpelling( translationUnit.cxTranslationUnit, token );
        _spelling = [ [ NSString alloc ] initWithCString: clang_getCString( spelling ) encoding: NSUTF8StringEncoding ];
        _kind     = ( CKTokenKind )clang_getTokenKind( token );
        location  = clang_getTokenLocation( translationUnit.cxTranslationUnit, token );
        range     = clang_getTokenExtent( translationUnit.cxTranslationUnit, token );
        
        clang_getExpansionLocation( location, translationUnit.cxFile, &line, &column, &offset );
        
        _line   = ( NSUInteger )line;
        _column = ( NSUInteger )column;
        _range  = NSMakeRange( ( NSUInteger )offset, range.end_int_data - range.begin_int_data );
    }
    
    return self;
}

@end
