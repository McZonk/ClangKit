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
    NSUInteger    _line;
    NSUInteger    _column;
    NSRange       _range;
    
@private
    
    RESERVED_IVARS( CKToken, 5 );
}

@property( atomic, readonly ) NSString    * spelling;
@property( atomic, readonly ) CKTokenKind   kind;
@property( atomic, readonly ) NSUInteger    line;
@property( atomic, readonly ) NSUInteger    column;
@property( atomic, readonly ) NSRange       range;

+ ( NSArray * )tokensForTranslationUnit: ( CKTranslationUnit * )translationUnit tokens: ( void ** )tokensPointer;

@end
