/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CKIndex;

@interface CKTranslationUnit: NSObject
{
@protected
    
    NSString          * _path;
    NSString          * _text;
    CXTranslationUnit   _cxTranslationUnit;
    CKIndex           * _index;
    char             ** _args;
    int                 _numArgs;
    NSArray           * _diagnostics;
    NSArray           * _tokens;
    void              * _tokensPointer;
    void              * _unsavedFile;
    
@private
    
    RESERVED_IVARS( CKDiagnostic, 5 );
}

@property( atomic, readonly        ) NSString        * path;
@property( atomic, readwrite, copy ) NSString        * text;
@property( atomic, readonly        ) CXTranslationUnit cxTranslationUnit;
@property( atomic, readonly        ) CKIndex         * index;
@property( atomic, readonly        ) NSArray         * diagnostics;
@property( atomic, readonly        ) NSArray         * tokens;

+ ( id )translationUnitWithPath: ( NSString * )path;
+ ( id )translationUnitWithPath: ( NSString * )path index: ( CKIndex * )index;
+ ( id )translationUnitWithPath: ( NSString * )path args: ( NSArray * )args;
+ ( id )translationUnitWithPath: ( NSString * )path index: ( CKIndex * )index args: ( NSArray * )args;
+ ( id )translationUnitWithText: ( NSString * )text language: ( CKLanguage )language;
+ ( id )translationUnitWithText: ( NSString * )text language: ( CKLanguage )language index: ( CKIndex * )index;
+ ( id )translationUnitWithText: ( NSString * )text language: ( CKLanguage )language args: ( NSArray * )args;
+ ( id )translationUnitWithText: ( NSString * )text language: ( CKLanguage )language index: ( CKIndex * )index args: ( NSArray * )args;
- ( id )initWithPath: ( NSString * )path;
- ( id )initWithPath: ( NSString * )path index: ( CKIndex * )index;
- ( id )initWithPath: ( NSString * )path args: ( NSArray * )args;
- ( id )initWithPath: ( NSString * )path index: ( CKIndex * )index args: ( NSArray * )args;
- ( id )initWithText: ( NSString * )text language: ( CKLanguage )language;
- ( id )initWithText: ( NSString * )text language: ( CKLanguage )language index: ( CKIndex * )index;
- ( id )initWithText: ( NSString * )text language: ( CKLanguage )language args: ( NSArray * )args;
- ( id )initWithText: ( NSString * )text language: ( CKLanguage )language index: ( CKIndex * )index args: ( NSArray * )args;
- ( void )reparse;

@end
