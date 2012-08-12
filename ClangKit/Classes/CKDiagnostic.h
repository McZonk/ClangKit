/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CKSourceLocation;
@class CKTranslationUnit;

typedef NSInteger CKDiagnosticSeverity;

FOUNDATION_EXPORT CKDiagnosticSeverity CKDiagnosticSeverityIgnored;
FOUNDATION_EXPORT CKDiagnosticSeverity CKDiagnosticSeverityNote;
FOUNDATION_EXPORT CKDiagnosticSeverity CKDiagnosticSeverityWarning;
FOUNDATION_EXPORT CKDiagnosticSeverity CKDiagnosticSeverityError;
FOUNDATION_EXPORT CKDiagnosticSeverity CKDiagnosticSeverityFatal;

@interface CKDiagnostic: NSObject
{
@protected
    
    CXDiagnostic         _cxDiagnostic;
    NSString           * _string;
    NSString           * _spelling;
    CKDiagnosticSeverity _severity;
    CKSourceLocation   * _location;
    NSArray            * _fixIts;
    
@private
    
    RESERVED_IVARS( CKDiagnostic, 5 );
}

@property( atomic, readonly ) CXDiagnostic         cxDiagnostic;
@property( atomic, readonly ) NSString           * string;
@property( atomic, readonly ) NSString           * spelling;
@property( atomic, readonly ) CKDiagnosticSeverity severity;
@property( atomic, readonly ) CKSourceLocation   * location;

+ ( NSArray * )diagnosticsForTranslationUnit: ( CKTranslationUnit * )translationUnit;
+ ( id )diagnosticWithTranslationUnit: ( CKTranslationUnit * )translationUnit index: ( NSUInteger )index;
- ( id )initWithTranslationUnit: ( CKTranslationUnit * )translationUnit index: ( NSUInteger )index;

@end
