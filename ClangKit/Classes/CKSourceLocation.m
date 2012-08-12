/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CKSourceLocation.h"
#import "CKSourceLocation+Private.h"
#import "CKDiagnostic.h"

@implementation CKSourceLocation

+ ( id )sourceLocationWithDiagnostic: ( CKDiagnostic * )diagnostic
{
    return [ [ [ self alloc ] initWithDiagnostic: diagnostic ] autorelease ];
}

- ( id )initWithDiagnostic: ( CKDiagnostic * )diagnostic
{
    if( ( self = [ self initWithCXSourceLocation: clang_getDiagnosticLocation( diagnostic.cxDiagnostic ) ] ) )
    {}
    
    return self;
}

@end
