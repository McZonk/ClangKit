/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CKTranslationUnit;

typedef NSInteger CKTokenKind;

FOUNDATION_EXPORT CKTokenKind CKTokenKindPunctuation;
FOUNDATION_EXPORT CKTokenKind CKTokenKindKeyword;
FOUNDATION_EXPORT CKTokenKind CKTokenKindIdentifier;
FOUNDATION_EXPORT CKTokenKind CKTokenKindLiteral;
FOUNDATION_EXPORT CKTokenKind CKTokenKindComment;

@interface CKToken: NSObject
{
@protected
    
    NSString    * _spelling;
    CKTokenKind   _kind;
    
@private
    
    RESERVED_IVARS( CKToken, 5 );
}

@property( atomic, readonly ) NSString    * spelling;
@property( atomic, readonly ) CKTokenKind   kind;

+ ( NSArray * )tokensForTranslationUnit: ( CKTranslationUnit * )translationUnit tokens: ( void ** )tokensPointer;

@end
