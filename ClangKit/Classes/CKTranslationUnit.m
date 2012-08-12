/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CKTranslationUnit.h"
#import "CKTranslationUnit+Private.h"
#import "CKIndex.h"
#import "CKDiagnostic.h"
#import "CKToken.h"

@implementation CKTranslationUnit

@synthesize path                = _path;
@synthesize cxTranslationUnit   = _cxTranslationUnit;
@synthesize index               = _index;

+ ( id )translationUnitWithPath: ( NSString * )path
{
    return [ [ [ self alloc ] initWithPath: path ] autorelease ];
}

+ ( id )translationUnitWithPath: ( NSString * )path index: ( CKIndex * )index
{
    return [ [ [ self alloc ] initWithPath: path index: index ] autorelease ];
}

+ ( id )translationUnitWithPath: ( NSString * )path args: ( NSArray * )args
{
    return [ [ [ self alloc ] initWithPath: path args: args ] autorelease ];
}

+ ( id )translationUnitWithPath: ( NSString * )path index: ( CKIndex * )index args: ( NSArray * )args
{
    return [ [ [ self alloc ] initWithPath: path index: index args: args ] autorelease ];
}

+ ( id )translationUnitWithText: ( NSString * )text language: ( CKLanguage )language
{
    return [ [ [ self alloc ] initWithText: text language: language ] autorelease ];
}

+ ( id )translationUnitWithText: ( NSString * )text language: ( CKLanguage )language index: ( CKIndex * )index
{
    return [ [ [ self alloc ] initWithText: text language: language index: index ] autorelease ];
}

+ ( id )translationUnitWithText: ( NSString * )text language: ( CKLanguage )language args: ( NSArray * )args
{
    return [ [ [ self alloc ] initWithText: text language: language args: args ] autorelease ];
}

+ ( id )translationUnitWithText: ( NSString * )text language: ( CKLanguage )language index: ( CKIndex * )index args: ( NSArray * )args
{
    return [ [ [ self alloc ] initWithText: text language: language index: index args: args ] autorelease ];
}

- ( id )initWithPath: ( NSString * )path
{
    return [ self initWithPath: path index: nil args: nil ];
}

- ( id )initWithPath: ( NSString * )path index: ( CKIndex * )index
{
    return [ self initWithPath: path index: index args: nil ];
}

- ( id )initWithPath: ( NSString * )path args: ( NSArray * )args
{
    return [ self initWithPath: path index: nil args: args ];
}

- ( id )initWithPath: ( NSString * )path index: ( CKIndex * )index args: ( NSArray * )args
{
    return [ self initWithPath: path text: nil index: index args: args ];
}

- ( id )initWithText: ( NSString * )text language: ( CKLanguage )language
{
    return [ self initWithText: text language: language index: nil args: nil ];
}

- ( id )initWithText: ( NSString * )text language: ( CKLanguage )language index: ( CKIndex * )index
{
    return [ self initWithText: text language: language index: index args: nil ];
}

- ( id )initWithText: ( NSString * )text language: ( CKLanguage )language args: ( NSArray * )args
{
    return [ self initWithText: text language: language index: nil args: args ];
}

- ( id )initWithText: ( NSString * )text language: ( CKLanguage )language index: ( CKIndex * )index args: ( NSArray * )args
{
    CFUUIDRef     uuid;
    CFStringRef   uuidString;
    NSString    * extension;
    NSString    * tempFileName;
    NSString    * tempFile;
    char          buffer[ 40 ];
    
    uuid         = CFUUIDCreate( kCFAllocatorDefault );
    uuidString   = CFUUIDCreateString( kCFAllocatorDefault, uuid );
    
    memset( buffer, 0, 40 );
    CFStringGetCString( uuidString, buffer, 40, kCFStringEncodingUTF8 );
    
    switch( language )
    {
        case CKLanguageC:       extension = @".c";      break;
        case CKLanguageCPP:     extension = @".cpp";    break;
        case CKLanguageObjC:    extension = @".m";      break;
        case CKLanguageObjCPP:  extension = @".mm";     break;
        case CKLanguageNone:    extension = @"";        break;
        default:                extension = @"";        break;
    }
    
    tempFileName = [ NSString stringWithFormat: @"ClangKit-%s%@", buffer, extension ];
    tempFile     = [ NSTemporaryDirectory() stringByAppendingPathComponent: tempFileName ];
    
    CFRelease( uuid );
    CFRelease( uuidString );
    
    if( mkstemp( ( char * )( tempFile.fileSystemRepresentation ) ) == -1 )
    {
        return nil;
    }
    
    return [ self initWithPath: tempFile text: text index: index args: args ];
}

- ( void )dealloc
{
    int i;
    
    if( _tokens.count > 0 )
    {
        clang_disposeTokens( _cxTranslationUnit, _tokensPointer, ( unsigned int )_tokens.count );
    }
    
    clang_disposeTranslationUnit( _cxTranslationUnit );
    
    for( i = 0; i < _numArgs; i++ )
    {
        free( _args[ i ] );
    }
    
    free( ( void * )_args );
    
    if( _unsavedFile != NULL )
    {
        [ FILE_MANAGER removeItemAtPath: _path error: NULL ];
        
        free( _unsavedFile );
    }
    
    RELEASE_IVAR( _path );
    RELEASE_IVAR( _text );
    RELEASE_IVAR( _index );
    RELEASE_IVAR( _diagnostics );
    
    [ super dealloc ];
}

- ( void )reparse
{
    RELEASE_IVAR( _diagnostics );
    
    if( _tokens.count > 0 )
    {
        clang_disposeTokens( _cxTranslationUnit, _tokensPointer, ( unsigned int )_tokens.count );
        
        _tokensPointer = NULL;
    }
    
    RELEASE_IVAR( _tokens );
    
    clang_reparseTranslationUnit
    (
        _cxTranslationUnit,
        ( _unsavedFile == NULL ) ? 0 : 1,
        _unsavedFile,
        clang_defaultEditingTranslationUnitOptions()
    );
}

- ( NSArray * )diagnostics
{
    @synchronized( self )
    {
        if( _diagnostics == nil )
        {
            _diagnostics = [ [ CKDiagnostic diagnosticsForTranslationUnit: self ] retain ];
        }
        
        return _diagnostics;
    }
}

- ( NSArray * )tokens
{
    @synchronized( self )
    {
        if( _tokens == nil )
        {
            _tokens = [ [ CKToken tokensForTranslationUnit: self tokens: &_tokensPointer ] retain ];
        }
        
        return _tokens;
    }
}

- ( NSString * )text
{
    @synchronized( self )
    {
        return _text;
    }
}

- ( void )setText: ( NSString * )text
{
    @synchronized( self )
    {
        if( _unsavedFile == NULL )
        {
            _unsavedFile = calloc( sizeof( struct CXUnsavedFile ), 1 );
        }
        
        if( _unsavedFile != NULL )
        {
            RELEASE_IVAR( _text );
            
            _text = [ text copy ];
            
            ( ( struct CXUnsavedFile * )_unsavedFile )->Filename = _path.fileSystemRepresentation;
            ( ( struct CXUnsavedFile * )_unsavedFile )->Contents = _text.UTF8String;
            ( ( struct CXUnsavedFile * )_unsavedFile )->Length   = _text.length;
            
            [ self reparse ];
        }
    }
}

- ( NSString * )description
{
    NSString * description;
    
    description = [ super description ];
    description = [ description stringByAppendingFormat: @"%@", self.path ];
    
    return description;
}

@end
