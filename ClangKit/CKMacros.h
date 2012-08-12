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

#ifndef __CK_MACROS_H__
#define __CK_MACROS_H__

#define L10N( __label__ )                       NSLocalizedString( [ NSString stringWithCString: __label__ encoding: NSUTF8StringEncoding ], nil )

#define RELEASE_IVAR( __ivar__ )                [ __ivar__ release ]; __ivar__ = nil

#define RESERVED_IVARS( __cls__, __num__ )     id _ ## __cls__ ## _Reserved[ __num__ ] __attribute__( ( unused ) )

#define NOTIFICATION_CENTER                     ( ( NSNotificationCenter * )[ NSNotificationCenter  defaultCenter ] )
#define FILE_MANAGER                            ( ( NSFileManager        * )[ NSFileManager         defaultManager ] )
#define APPLICATION                             ( ( NSApplication        * )[ NSApplication         sharedApplication ] )
#define DEFAULTS                                ( ( NSUserDefaults       * )[ NSUserDefaults        standardUserDefaults ] )
#define BUNDLE                                  ( ( NSBundle             * )[ NSBundle              mainBundle ] )
#define WORKSPACE                               ( ( NSWorkspace          * )[ NSWorkspace           sharedWorkspace ] )

#define Log( object )                                                           \
    NSLog                                                                       \
    (                                                                           \
        @"\n"                                                                   \
        @"\n"                                                                   \
        @"\tFile:           %@\n"                                               \
        @"\tLine:           %u\n"                                               \
        @"\tSymbol:         %s\n"                                               \
        @"\tAddress:        %p\n"                                               \
        @"\tRetain count:   %lu\n"                                              \
        @"\tClass:          %@\n"                                               \
        @"\tSuper class:    %@\n"                                               \
        @"\n"                                                                   \
        @"\tDescription:"                                                       \
        @"\n"                                                                   \
        @"\t%@\n"                                                               \
        @"\n",                                                                  \
        [ [ NSString stringWithFormat: @"%s", __FILE__ ] lastPathComponent ],   \
        __LINE__,                                                               \
        #object,                                                                \
        ( void * )object,                                                       \
        [ object retainCount ],                                                 \
        NSStringFromClass( [ object class ] ),                                  \
        NSStringFromClass( [ object superclass ] ),                             \
        object                                                                  \
    )

#define LogPoint( point )                       \
    NSLog                                       \
    (                                           \
        @"NSPoint:\n"                           \
        @"    X: %f\n"                          \
        @"    Y: %f",                           \
        point.x,                                \
        point.y                                 \
    )

#define LogSize( size )                         \
    NSLog                                       \
    (                                           \
        @"NSSize:\n"                            \
        @"    Width:  %f\n"                     \
        @"    Height: %f",                      \
        size.width,                             \
        size.height                             \
    )
 
#define LogRect( rect )                         \
    NSLog                                       \
    (                                           \
        @"NSRect:\n"                            \
        @"    X:      %f\n"                     \
        @"    Y:      %f\n"                     \
        @"    Width:  %f\n"                     \
        @"    Height: %f",                      \
        ( rect ).origin.x,                      \
        ( rect ).origin.y,                      \
        ( rect ).size.width,                    \
        ( rect ).size.height                    \
    )

#define LogRange( range )                       \
    NSLog                                       \
    (                                           \
        @"NSRange:\n"                           \
        @"    Location: %lu\n"                  \
        @"    Length:   %lu\n",                 \
        ( unsigned long )range.location,        \
        ( unsigned long )range.length           \
    )
    
#define FLOAT_EQUAL( __a__, __b__ )     ( bool )( fabsf( ( float )__a__ - ( float )__b__ ) < FLT_EPSILON )
#define FLOAT_ZERO( __a__ )             ( bool )( fabsf( ( float )__a__ ) < FLT_EPSILON )
#define DOUBLE_EQUAL( __a__, __b__ )    ( bool )( fabs( ( double )__a__ - ( double )__b__ ) < DBL_EPSILON )
#define DOUBLE_ZERO( __a__ )            ( bool )( fabs( ( double )__a__ ) < DBL_EPSILON )
#define LDOUBLE_EQUAL( __a__, __b__ )   ( bool )( fabsl( ( long double )__a__ - ( long double )__b__ ) < LDBL_EPSILON )
#define LDOUBLE_ZERO( __a__ )           ( bool )( fabsl( ( long double )__a__ ) < LDBL_EPSILON )
#define CGFLOAT_EQUAL( __a__, __b__ )   ( bool )( fabs( ( CGFloat )__a__ - ( CGFloat )__b__ ) < DBL_EPSILON )
#define CGFLOAT_ZERO( __a__ )           ( bool )( fabs( ( CGFloat )__a__ ) < DBL_EPSILON )

#endif /* __CK_MACROS_H__ */
