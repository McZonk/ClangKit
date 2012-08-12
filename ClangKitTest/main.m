/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

int main( void )
{
    CKTranslationUnit * tu;
    CKDiagnostic      * d;
    
    @autoreleasepool
    {
        tu = [ CKTranslationUnit    translationUnitWithText:    @"int main( void ) { return 0; }"
                                    language:                   CKLanguageC
                                    args:                       [ NSArray arrayWithObject: @"-Weverything" ]
             ];
        
        for( d in tu.diagnostics )
        {
            NSLog( @"Diagnostic: %@", d );
            NSLog( @"FixIts: %@", d.fixIts );
        }
        
        NSLog( @"%@", tu.tokens );
        
        tu.text = @"int main( void ) { int x = 0\nreturn 1; }\n";
        
        for( d in tu.diagnostics )
        {
            NSLog( @"Diagnostic: %@", d );
            NSLog( @"FixIts: %@", d.fixIts );
        }
        
        NSLog( @"%@", tu.tokens );
    }
    
    return 0;
}

