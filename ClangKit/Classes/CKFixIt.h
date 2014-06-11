/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina - www.xs-labs.com
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

/*!
 * @header          CKFixit.h
 * @copyright       (c) 2010-2014 - Jean-David Gadina - www.xs-labs.com
 * @author          Jean-David Gadina - www.xs-labs.com
 * @abstract        ClangKit fix-it class
 */

@class CKDiagnostic;

/*!
 * @class           CKFixIt
 * @abstract        Fix-it class
 */
@interface CKFixIt: NSObject
{
@protected
    
    NSString * _string;
    NSRange    _range;
}

/*!
 * @property        string
 * @abstract        The fix-it's string
 */
@property( atomic, readonly ) NSString * string;

/*!
 * @property        range
 * @abstract        The fix-it's range
 */
@property( atomic, readonly ) NSRange range;

/*!
 * @method          fixItsForDiagnostic:
 * @abstract        Gets fix-it objects from a diagnostic object
 * @param           diagnostic  The diagnostic object
 * @return          An array of fix-it objects
 */
+ ( NSArray * )fixItsForDiagnostic: ( CKDiagnostic * )diagnostic;

/*!
 * @method          fixItWithDiagnostic:index:
 * @abstract        Gets a fix-it object from a diagnostic object
 * @param           diagnostic  The diagnostic object
 * @param           index       The index
 * @return          The fix-it object
 * @discussion      The returned object is autoreleased.
 */
+ ( id )fixItWithDiagnostic: ( CKDiagnostic * )diagnostic index: ( NSUInteger )index;

/*!
 * @method          initWithDiagnostic:index:
 * @abstract        Initializes a fix-it object with a diagnostic object
 * @param           diagnostic  The diagnostic object
 * @param           index       The index
 * @return          The fix-it object
 */
- ( id )initWithDiagnostic: ( CKDiagnostic * )diagnostic index: ( NSUInteger )index;
    
@end
