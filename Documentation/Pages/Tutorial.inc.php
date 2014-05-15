<div class="xsdoc-file">
    <?php
        if( !isset( $_GET[ 'xsdoc-print' ] ) )
        {
    ?>
    <div class="xsdoc-file-toc">
        <h2>Table of contents</h2>
        <h3><a href="#implementation">Implementation</a></h3>
        <h3><a href="#usage">Basic usage</a></h3>
        <ul>
            <li><a href="#usage-tokens">Tokens</a></li>
            <li><a href="#usage-cursors">Cursors</a></li>
            <li><a href="#usage-diagnostics">Diagnostics</a></li>
            <li><a href="#usage-fixits">Fix-its</a></li>
            <li><a href="#usage-completion">Code completion</a></li>
        </ul>
        <h3><a href="#example">Example</a></h3>
    </div>
    <?php
        }
    ?>
    <div class="xsdoc-file-content">
        <h2>ClangKit tutorial</h2>
        <a name="implementation"></a>
        <h3>Implementation</h3>
        <p>
            In order to build the framework, you'll first need to build Clang/LLVM.<br />
            Sources are not provided, as it would take a lot of repository space.
        </p>
        <p>
            A makefile is provided to ease the build process.<br />
            Clang/LLVM sources will be automatically checked-out from the SVN repositories.
        </p>
        <p>
            From the ClangKit directory, `cd` inside the `ClangKit/LLVM` directory and type:
        </p>
        <div class="xsdoc-code-block">
            <code>make</code>
        </div>
        <p>
            This will check-out the Clang/LLVM source and build the required libraries.
        </p>
        <p>
            You'll then be able to build the framework, and use it from other Xcode projects.
        </p>
        <a name="usage"></a>
        <h3>Basic usage</h3>
        <p>
            The first class you'll need to use is `CKTranslationUnit`.<br />
            It can be instantiated from an existing file, or from a `NSString`.
        </p>
        <div class="xsdoc-code-block">
            <code>CKTranslationUnit * tu;</code><br />
            <code></code><br />
            <code>/* Instantiation from an existing file */</code><br />
            <code>tu = [ CKTranslationUnit translationUnitWithPath: @"~/some/file.c" ];</code><br />
            <code></code><br />
            <code>/* Instantiation from a string */</code><br />
            <code>tu = [ CKTranslationUnit translationUnitWithText: @"int main( void ) { return 0; }\n" ];</code>
        </div>
        <p>
            Once you got an existing instance of `CKTranslationUnit`, you can set the text to be parsed using the `text` property, even if the file has not yet been saved.
        </p>
        <div class="xsdoc-code-block">
            <code>tu.text = @"int main( void ) { return 1; }\n";</code>
        </div>
        <p>
            This may be useful for code editors which managed unsaved files.
        </p>
        <a name="usage-tokens"></a>
        <h4>Tokens</h4>
        <p>
            Tokens can be retrieved from a `CKTranslationUnit` instance using the `tokens` property:
        </p>
        <div class="xsdoc-code-block">
            <code>NSLog( @"%@", tu.tokens );</code>
        </div>
        <p>
            It returns an array of `CKToken` instances, each one containing the token type, as well as the line number, column number and text range.
        </p>
        <p>
            Token types are:
        </p>
        <div class="xsdoc-code-block">
            <code>CKTokenKind CKTokenKindPunctuation;</code><br />
            <code>CKTokenKind CKTokenKindKeyword;</code><br />
            <code>CKTokenKind CKTokenKindIdentifier;</code><br />
            <code>CKTokenKind CKTokenKindLiteral;</code><br />
            <code>CKTokenKind CKTokenKindComment;</code>
        </div>
        <a name="usage-cursors"></a>
        <h4>Cursors</h4>
        <p>
            Each token has an associated cursor (the `cursor` property), that you can use to retrieve extended informations about the symbol.
        </p>
        <p>
            Cursors are the key for everything, and it would take too much lines describing all their features.<br />
            Take a look at the code, and maybe read some official Clang documentation.
        </p>
        <a name="usage-diagnostics"></a>
        <h4>Diagnostics</h4>
        <p>
            Diagnostics are available through the `diagnostics` property.<br />
            It returns an array of `CKDiagnostic` instances, each one containing the diagnostic severity and message.
        </p>
        <p>
            Diagnostic severities are:
        </p>
        <div class="xsdoc-code-block">
            <code>CKDiagnosticSeverity CKDiagnosticSeverityIgnored;</code><br />
            <code>CKDiagnosticSeverity CKDiagnosticSeverityNote;</code><br />
            <code>CKDiagnosticSeverity CKDiagnosticSeverityWarning;</code><br />
            <code>CKDiagnosticSeverity CKDiagnosticSeverityError;</code><br />
            <code>CKDiagnosticSeverity CKDiagnosticSeverityFatal;</code>
        </div>
        <a name="usage-fixits"></a>
        <h4>Fix-its</h4>
        <p>
            Each `CKDiagnostic` instance may contains fix-its, through its `fixIts` property.<br />
            `CKFixIt` instances contain the fix-it text, as well as a `NSRange`, indicating where the text should be added/replaced.
        </p>
        <a name="usage-completion"></a>
        <h4>Code completion</h4>
        <p>
            Code completion results can be retrieved from a translation unit (`CKTranslationUnit`):
        </p>
        <div class="xsdoc-code-block">
            <code>- ( NSArray * )completionResultsForLine: ( NSUInteger )line column: ( NSUInteger )column;</code>
        </div>
        <p>
            Given a specific line and column, you'll be able to get completion results for that specific location.<br />
            The results array will contains instances of `CKCompletionResult`.
        </p>
        <p>
            Each `CKCompletionResult` may contain several chunks (`CKCompletionChunk`), accessible to its `chunks` property.<br />
            The chunks are used to describe the completion result.
        </p>
        <a name="example"></a>
        <h3>Example</h3>
        <p>
            Here's a basic example:
        </p>
        <div class="xsdoc-code-block">
            <code>#include &lt;ClangKit/ClangKit.h&gt;</code><br />
            <code></code><br />
            <code>int main( void )</code><br />
            <code>{</code><br />
            <code>    CKTranslationUnit * tu;</code><br />
            <code></code><br />
            <code>    @autoreleasepool</code><br />
            <code>    {</code><br />
            <code>        tu = [ CKTranslationUnit   translationUnitWithText:    @"int main( void ) { return 0; }"</code><br />
            <code>                                   language:                   CKLanguageC</code><br />
            <code>                                   args:                       [ NSArray arrayWithObject: @"-Weverything" ]</code><br />
            <code>             ];</code><br />
            <code></code><br />
            <code>        NSLog( @"%@", tu.diagnostics );</code><br />
            <code>        NSLog( @"%@", tu.tokens );</code><br />
            <code>    }</code><br />
            <code></code><br />
            <code>    return 0;</code><br />
            <code>}</code>
        </div>
        <p>
            The output will be:
        </p>
        <div class="xsdoc-code-block">
            <code>(</code><br />
            <code>    "&lt;CKDiagnostic: 0x101c00710&gt;: Warning[1:31] - warning: no newline at end of file [-Wnewline-eof]"</code><br />
            <code>)</code><br />
            <code>(</code><br />
            <code>    "&lt;CKToken: 0x100715920&gt;: Keyword[1:1] int (FunctionDecl)",</code><br />
            <code>    "&lt;CKToken: 0x100720970&gt;: Identifier[1:5] main (FunctionDecl)",</code><br />
            <code>    "&lt;CKToken: 0x100720f40&gt;: Punctuation[1:9] ( (FunctionDecl)",</code><br />
            <code>    "&lt;CKToken: 0x100721540&gt;: Keyword[1:11] void (FunctionDecl)",</code><br />
            <code>    "&lt;CKToken: 0x100721b60&gt;: Punctuation[1:16] ) (FunctionDecl)",</code><br />
            <code>    "&lt;CKToken: 0x100722160&gt;: Punctuation[1:18] { (CompoundStmt)",</code><br />
            <code>    "&lt;CKToken: 0x100722760&gt;: Keyword[1:20] return (ReturnStmt)",</code><br />
            <code>    "&lt;CKToken: 0x1007229e0&gt;: Literal[1:27] 0 (IntegerLiteral)",</code><br />
            <code>    "&lt;CKToken: 0x100722fc0&gt;: Punctuation[1:28] ; (CompoundStmt)",</code><br />
            <code>    "&lt;CKToken: 0x1007235a0&gt;: Punctuation[1:30] } (CompoundStmt)"</code><br />
            <code>)</code>
        </div>
    </div>
</div>

