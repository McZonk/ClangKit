/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CKToken.h"
#import "CKToken+Private.h"
#import "CKTranslationUnit.h"

CKTokenKind CKTokenKindPunctuation  = CXToken_Punctuation;
CKTokenKind CKTokenKindKeyword      = CXToken_Keyword;
CKTokenKind CKTokenKindIdentifier   = CXToken_Identifier;
CKTokenKind CKTokenKindLiteral      = CXToken_Literal;
CKTokenKind CKTokenKindComment      = CXToken_Comment;

@implementation CKToken

@synthesize spelling = _spelling;
@synthesize kind     = _kind;
@synthesize line     = _line;
@synthesize column   = _column;
@synthesize range    = _range;

+ ( NSArray * )tokensForTranslationUnit: ( CKTranslationUnit * )translationUnit tokens: ( void ** )tokensPointer
{
    NSError        * error;
    CXToken        * cxTokens;
    NSMutableArray * tokens;
    CXFile           file;
    CXSourceLocation startLocation;
    CXSourceLocation endLocation;
    CXSourceRange    range;
    unsigned int     numTokens;
    unsigned int     i;
    CKToken        * token;
    
    ( void )translationUnit;
    
    error = nil;
    if( error != nil )
    {
        return nil;
    }
    
    file            = clang_getFile( translationUnit.cxTranslationUnit, translationUnit.path.fileSystemRepresentation );
    startLocation   = clang_getLocationForOffset( translationUnit.cxTranslationUnit, file, 0 );
    endLocation     = clang_getLocationForOffset( translationUnit.cxTranslationUnit, file, ( unsigned int )translationUnit.text.length );
    range           = clang_getRange( startLocation, endLocation );
    numTokens       = 0;
    cxTokens        = NULL;
    
    clang_tokenize
    (
        translationUnit.cxTranslationUnit,
        range,
        &cxTokens,
        &numTokens
    );
    
    if( numTokens == 0 )
    {
        return nil;
    }
    
    clang_annotateTokens( translationUnit.cxTranslationUnit, cxTokens, numTokens, NULL );
    
    tokens = [ NSMutableArray arrayWithCapacity: ( NSUInteger )numTokens ];
    
    for( i = 0; i < numTokens; i++ )
    {
        token = [ [ CKToken alloc ] initWithCXToken: cxTokens[ i ] translationUnit: translationUnit ];
        
        if( token != nil )
        {
            [ tokens addObject: token ];
            [ token release ];
        }
    }
    
    if( tokensPointer != NULL )
    {
        *( tokensPointer ) = ( char * )cxTokens;
    }
    
    return [ NSArray arrayWithArray: tokens ];
}

- ( void )dealloc
{
    RELEASE_IVAR( _spelling );
    
    [ super dealloc ];
}

- ( NSString * )description
{
    NSString * description;
    NSString * kind;
    
    if( self.kind == CKTokenKindPunctuation )
    {
        kind = @"Punctuation";
    }
    else if( self.kind == CKTokenKindKeyword )
    {
        kind = @"Keyword";
    }
    else if( self.kind == CKTokenKindIdentifier )
    {
        kind = @"Identifier";
    }
    else if( self.kind == CKTokenKindLiteral )
    {
        kind = @"Literal";
    }
    else if( self.kind == CKTokenKindComment )
    {
        kind = @"Comment";
    }
    else
    {
        kind = @"Unknown";
    }
    
    description = [ super description ];
    description = [ description stringByAppendingFormat: @": %@ - %@ - [%lu:%lu]", kind, self.spelling, self.line, self.column ];
    
    return description;
}

@end
