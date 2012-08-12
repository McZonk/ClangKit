/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#define PRINT( s ) printf( s );

int main( void )
{
    Test          t;
    int           x = -1;
    unsigned long y = 42;
    char        * s = "hello, world";
    float         f = 0.2f;
    char          c = 'a';
    
    x = y;
    
    PRINT( "hello, universe" );
    
    return 0;
}
