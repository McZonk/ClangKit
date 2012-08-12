/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#ifndef __CK_TYPES_H__
#define __CK_TYPES_H__

#ifndef CLANG_C_INDEX_H

typedef void * CXDiagnostic;
typedef void * CXIndex;
typedef void * CXTranslationUnit;
typedef void * CXFile;

#endif

typedef enum
{
    CKLanguageNone   = 0x00,
    CKLanguageC      = 0x01,
    CKLanguageCPP    = 0x02,
    CKLanguageObjC   = 0x03,
    CKLanguageObjCPP = 0x04
}
CKLanguage;

#endif /* __CK_TYPES_H__ */
