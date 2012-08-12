/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CKToken+Private.h"

@implementation CKToken( Private )

- ( id )initWithCXToken: ( CXToken )token CXTranslationUnit: ( CXTranslationUnit )translationUnit
{
    CXString spelling;
    
    if( ( self = [ self init ] ) )
    {
        spelling  = clang_getTokenSpelling( translationUnit, token );
        _spelling = [ [ NSString alloc ] initWithCString: clang_getCString( spelling ) encoding: NSUTF8StringEncoding ];
        _kind     = ( CKTokenKind )clang_getTokenKind( token );
    }
    
    return self;
}

@end
