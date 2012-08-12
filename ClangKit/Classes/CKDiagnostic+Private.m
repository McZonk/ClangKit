/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved.
 * 
 * Boost Software License - Version 1.0 - August 17th, 2003
 * 
 * Permission is hereby granted, free of charge, to any person or organization
 * obtaining a copy of the software and accompanying documentation covered by
 * this license (the "Software") to use, reproduce, display, distribute,
 * execute, and transmit the Software, and to prepare derivative works of the
 * Software, and to permit third-parties to whom the Software is furnished to
 * do so, all subject to the following:
 * 
 * The copyright notices in the Software and this entire statement, including
 * the above license grant, this restriction and the following disclaimer,
 * must be included in all copies of the Software, in whole or in part, and
 * all derivative works of the Software, unless such copies or derivative
 * works are solely in the form of machine-executable object code generated by
 * a source language processor.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
 * SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
 * FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 ******************************************************************************/
 
/* $Id$ */

#import "CKDiagnostic+Private.h"
#import "CKTranslationUnit.h"
#import "CKFixIt.h"

@implementation CKDiagnostic( Private )

- ( id )initWithCXDiagnostic: ( CXDiagnostic )diagnostic translationUnit: ( CKTranslationUnit * )translationUnit
{
    CXString         string;
    CXString         spelling;
    CXSourceLocation location;
    CXSourceRange    range;
    unsigned int     line;
    unsigned int     column;
    unsigned int     offset;
    
    if( ( self = [ self init ] ) )
    {
        _cxDiagnostic = diagnostic;
        string        = clang_formatDiagnostic( _cxDiagnostic, clang_defaultDiagnosticDisplayOptions() );
        spelling      = clang_getDiagnosticSpelling( _cxDiagnostic );
        _string       = [ [NSString alloc ] initWithCString: clang_getCString( string ) encoding: NSUTF8StringEncoding ];
        _spelling     = [ [NSString alloc ] initWithCString: clang_getCString( spelling ) encoding: NSUTF8StringEncoding ];
        _severity     = ( CKDiagnosticSeverity )clang_getDiagnosticSeverity( _cxDiagnostic );
        
        clang_disposeString( string );
        clang_disposeString( spelling );
        
        location  = clang_getDiagnosticLocation( diagnostic );
        range     = clang_getDiagnosticRange( diagnostic, 0 );
                
        clang_getExpansionLocation( location, translationUnit.cxFile, &line, &column, &offset );
        
        _line   = ( NSUInteger )line;
        _column = ( NSUInteger )column;
        _range  = NSMakeRange( ( NSUInteger )offset, range.end_int_data - range.begin_int_data );
        
        _fixIts = [ [ CKFixIt fixItsForDiagnostic: self ] retain ];
    }
    
    return self;
}

@end
