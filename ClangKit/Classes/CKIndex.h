/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@interface CKIndex: NSObject
{
@protected
    
    CXIndex _cxIndex;
    BOOL    _excludeDeclarationsFromPCH;
    BOOL    _displayDiagnostics;
    
@private
    
    RESERVED_IVARS( CKDiagnostic, 5 );
}

@property( atomic, readonly          ) CXIndex   cxIndex;
@property( atomic, readwrite, assign ) BOOL      excludeDeclarationsFromPCH;
@property( atomic, readwrite, assign ) BOOL      displayDiagnostics;

+ ( id )index;

@end
