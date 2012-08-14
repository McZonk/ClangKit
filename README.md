ClangKit
========

Objective-C (Foundation) frontend to LibClang
---------------------------------------------

ClangKit provides an Objective-C frontend to LibClang.  
Source tokenization, diagnostics and fix-its are actually implemented.

ClangKit is intended to be used as a private framework, in an application's bundle.

Possible applications includes:

  - Source code syntax highlighting
  - Source code tokenization
  - Source code diagnostics
  - Source code static analysis

### Language support

The project actually supports parsing C, C++, Objective-C and Objective-C++ source code.

### iOS note:

The project is not yet compatible with iOS, but everything should be fine, as LibClang is actually compiled as a static library.  
A port should be available soon.

### Implementation:

In order to build the framework, you'll first need to build Clang/LLVM.  
Sources are not provided, as it would take a lot of repository space.

A makefile is provided to ease the build process.  
Clang/LLVM sources will be automatically checked-out from the SVN repositories.

From the ClangKit directory, `cd` inside the `ClangKit/LLVM` directory and type:

    make
    
This will check-out the Clang/LLVM source and build the required libraries.

You'll then be able to build the framework, and use it from other Xcode projects.

### Basic usage:

The first class you'll need to use is `CKTranslationUnit`.  
It can be instantiated from an existing file, or from a `NSString`.

    CKTranslationUnit * tu;
    
	/* Instanciation from an existing file */
    tu = [ CKTranslationUnit translationUnitWithPath: @"~/some/file.c" ];
	
	/* Instanciation from a string */
    tu = [ CKTranslationUnit translationUnitWithText: @"int main( void ) { return 0; }\n" ];
	
Once you got an existing instance of `CKTranslationUnit`, you can set the text to be parsed using the `text` property, even if the file has not yet been saved.

    tu.text = @"int main( void ) { return 1; }\n";
    
This may be useful for code editors which managed unsaved files.

#### Tokens:

Tokens can be retrieved from a `CKTranslationUnit` instance using the `tokens` property:

    NSLog( @"%@", tu.tokens );
    
It returns an array of `CKToken` instances, each one containing the token type, as well as the line number, column number and text range.

Token types are:

    CKTokenKind CKTokenKindPunctuation;
	CKTokenKind CKTokenKindKeyword;
	CKTokenKind CKTokenKindIdentifier;
	CKTokenKind CKTokenKindLiteral;
	CKTokenKind CKTokenKindComment;

#### Cursors: 

Each token has an associated cursor (the `cursor` property), that you can use to retrieve extended informations about the symbol.

Cursors are the key for everything, and it would take too much lines describing all their features.  
Take a look at the code, and maybe read some official Clang documentation.

#### Diagnostics: 

Diagnostics are available through the `diagnostics` property.  
It returns an array of `CKDiagnostic` instances, each one containing the diagnostic severity and message.

Diagnostic severities are:

    CKDiagnosticSeverity CKDiagnosticSeverityIgnored;
	CKDiagnosticSeverity CKDiagnosticSeverityNote;
	CKDiagnosticSeverity CKDiagnosticSeverityWarning;
	CKDiagnosticSeverity CKDiagnosticSeverityError;
	CKDiagnosticSeverity CKDiagnosticSeverityFatal;

#### Fix-its:

Each `CKDiagnostic` instance may contains fix-its, through its `fixIts` property.

### ARC note:

The project does not use ARC (automatic reference counting), and will certainly never use it.  
If this is an issue for you, you might consider using something else, or simply learn about reference-counting basics.

Example:
--------

Here's a basic example:
	
	#include <ClangKit/ClangKit.h>
	
	int main( void )
	{
		CKTranslationUnit * tu;
		
		@autoreleasepool
		{
			tu = [ CKTranslationUnit	translationUnitWithText:	@"int main( void ) { return 0; }"
                                    	language:					CKLanguageC
                                    	args:						[ NSArray arrayWithObject: @"-Weverything" ]
             	 ];
        
        	NSLog( @"%@", tu.diagnostics );
        	NSLog( @"%@", tu.tokens );
		}
		
		return 0;
	}
	
The output will be:

    <CKDiagnostic: 0x101c00710>: Warning[1:31] - warning: no newline at end of file [-Wnewline-eof]
    (
        "<CKToken: 0x100715920>: Keyword[1:1] int (FunctionDecl)",
    	"<CKToken: 0x100720970>: Identifier[1:5] main (FunctionDecl)",
    	"<CKToken: 0x100720f40>: Punctuation[1:9] ( (FunctionDecl)",
    	"<CKToken: 0x100721540>: Keyword[1:11] void (FunctionDecl)",
    	"<CKToken: 0x100721b60>: Punctuation[1:16] ) (FunctionDecl)",
    	"<CKToken: 0x100722160>: Punctuation[1:18] { (CompoundStmt)",
    	"<CKToken: 0x100722760>: Keyword[1:20] return (ReturnStmt)",
    	"<CKToken: 0x1007229e0>: Literal[1:27] 0 (IntegerLiteral)",
    	"<CKToken: 0x100722fc0>: Punctuation[1:28] ; (CompoundStmt)",
    	"<CKToken: 0x1007235a0>: Punctuation[1:30] } (CompoundStmt)"
	)

License
-------

ClangKit is published under the terms of the BOOST license.  
Feel free to use and modify it.

Please see the `LICENSE.md` file for the full license terms.
