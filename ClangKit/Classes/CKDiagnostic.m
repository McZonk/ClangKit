/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CKDiagnostic.h"
#import "CKDiagnostic+Private.h"
#import "CKSourceLocation.h"
#import "CKTranslationUnit.h"

CKDiagnosticSeverity CKDiagnosticSeverityIgnored  = CXDiagnostic_Ignored;
CKDiagnosticSeverity CKDiagnosticSeverityNote     = CXDiagnostic_Note;
CKDiagnosticSeverity CKDiagnosticSeverityWarning  = CXDiagnostic_Warning;
CKDiagnosticSeverity CKDiagnosticSeverityError    = CXDiagnostic_Error;
CKDiagnosticSeverity CKDiagnosticSeverityFatal    = CXDiagnostic_Fatal;

@implementation CKDiagnostic

@synthesize cxDiagnostic    = _cxDiagnostic;
@synthesize location        = _location;
@synthesize string          = _string;
@synthesize spelling        = _spelling;
@synthesize severity        = _severity;

+ ( NSArray * )diagnosticsForTranslationUnit: ( CKTranslationUnit * )translationUnit
{
    unsigned int     numDiagnostics;
    unsigned int     i;
    NSMutableArray * diagnostics;
    CKDiagnostic   * diagnostic;
    
    numDiagnostics = clang_getNumDiagnostics( translationUnit.cxTranslationUnit );
    diagnostics    = [ NSMutableArray arrayWithCapacity: ( NSUInteger )numDiagnostics ];
    
    for( i = 0; i < numDiagnostics; i++ )
    {
        diagnostic = [ CKDiagnostic diagnosticWithTranslationUnit: translationUnit index: i ];
        
        if( diagnostic != nil )
        {
            [ diagnostics addObject: diagnostic ];
        }
    }
    
    return [ NSArray arrayWithArray: diagnostics ];
}

+ ( id )diagnosticWithTranslationUnit: ( CKTranslationUnit * )translationUnit index: ( NSUInteger )index
{
    return [ [ [ self alloc ] initWithTranslationUnit: ( CKTranslationUnit * )translationUnit index: index ] autorelease ];
}

- ( id )initWithTranslationUnit: ( CKTranslationUnit * )translationUnit index: ( NSUInteger )index
{
    if( ( self = [ self initWithCXDiagnostic: clang_getDiagnostic( translationUnit.cxTranslationUnit, ( unsigned int )index ) ] ) )
    {}
    
    return self;
}

- ( void )dealloc
{
    clang_disposeDiagnostic( _cxDiagnostic );
    
    RELEASE_IVAR( _location );
    RELEASE_IVAR( _fixIts );
    RELEASE_IVAR( _string );
    RELEASE_IVAR( _spelling );
    
    [ super dealloc ];
}

- ( NSString * )description
{
    NSString * description;
    NSString * severity;
    
    if( self.severity == CKDiagnosticSeverityError )
    {
        severity = @"Error";
    }
    else if( self.severity == CKDiagnosticSeverityFatal )
    {
        severity = @"Fatal";
    }
    else if( self.severity == CKDiagnosticSeverityIgnored )
    {
        severity = @"Ignored";
    }
    else if( self.severity == CKDiagnosticSeverityNote )
    {
        severity = @"Note";
    }
    else if( self.severity == CKDiagnosticSeverityWarning )
    {
        severity = @"Warning";
    }
    else
    {
        severity = @"Unknown";
    }
    
    description = [ super description ];
    description = [ description stringByAppendingFormat: @": %@ - %@", severity, self.string ];
    
    return description;
}

@end
