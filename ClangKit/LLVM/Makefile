#-------------------------------------------------------------------------------
# Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
# All rights reserved
#-------------------------------------------------------------------------------

# $Id$

#-------------------------------------------------------------------------------
# Software
#-------------------------------------------------------------------------------

RM                  = rm
TAR                 = tar
MAKE                = make
CD                  = cd
SUDO                = sudo

#-------------------------------------------------------------------------------
# Software arguments
#-------------------------------------------------------------------------------

ARGS_RM             = -rf
ARGS_TAR            = -xf
ARGS_MAKE           = 

#-------------------------------------------------------------------------------
# Paths
#-------------------------------------------------------------------------------

DIR_BUILD           = ./Build/
DIR_LLVM            = ./Source/
DIR_CLANG           = $(DIR_LLVM)tools/clang/
DIR_CRT             = $(DIR_LLVM)projects/compiler-rt/

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean llvm_co clang_co crt_co llvm_build

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: llvm_build

# Cleans the build files
clean:
	@echo "    *** Cleaning all build files"
	@$(RM) $(ARGS_RM) $(DIR_BUILD)*

# LLVM build
llvm_build:
	@echo "    *** Building LLVM toolchain"
	@$(CD) $(DIR_BUILD) && ../$(DIR_LLVM)configure --enable-optimized
	@$(CD) $(DIR_BUILD) && $(MAKE)

