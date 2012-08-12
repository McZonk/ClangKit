/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CKDiagnostic;

@interface CKFixIt: NSObject
{
@protected
    
    NSString * _string;
    NSRange    _range;
    
@private
    
    RESERVED_IVARS( CKFixIt, 5 );
}

@property( atomic, readonly ) NSString * string;
@property( atomic, readonly ) NSRange    range;

+ ( NSArray * )fixItsForDiagnostic: ( CKDiagnostic * )diagnostic;
+ ( id )fixItWithDiagnostic: ( CKDiagnostic * )diagnostic index: ( NSUInteger )index;
- ( id )initWithDiagnostic: ( CKDiagnostic * )diagnostic index: ( NSUInteger )index;
    
@end
