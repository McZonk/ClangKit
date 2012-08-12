/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CKDiagnostic;

@interface CKSourceLocation: NSObject
{
@protected
    
    
    
@private
    
    RESERVED_IVARS( CKSourceLocation, 5 );
}

+ ( id )sourceLocationWithDiagnostic: ( CKDiagnostic * )diagnostic;
- ( id )initWithDiagnostic: ( CKDiagnostic * )diagnostic;

@end
