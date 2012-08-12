/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@interface Foo: NSObject
{
@protected
    
    NSUInteger _x;
}

@property( atomic, readonly ) x;

@end

@implementation Foo

@synthesize x = _x;

@end

class Bar
{
    Bar( void )
    {}
    
    virtual ~Bar( void )
    {}
};

int main( void )
{
    @autoreleasepool
    {
        void ( ^ block )( void );
        
        block = ^
        {
            NSLog( @"hello, world" );
        };
        
        block();
    }
    
    return 0;
}
