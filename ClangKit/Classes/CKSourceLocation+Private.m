/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CKSourceLocation+Private.h"

@implementation CKSourceLocation( Private )

- ( id )initWithCXSourceLocation: ( CXSourceLocation )location
{
    if( ( self = [ self init ] ) )
    {
        ( void )location;
    }
    
    return self;
}

@end
