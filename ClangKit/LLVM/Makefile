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
SVN                 = svn
CD                  = cd
SUDO                = sudo

#-------------------------------------------------------------------------------
# Software arguments
#-------------------------------------------------------------------------------

ARGS_RM             = -rf
ARGS_TAR            = -xf
ARGS_MAKE           = 
ARGS_SVN_CO         = checkout
ARGS_SVN_UP         = update

#-------------------------------------------------------------------------------
# Source repositories
#-------------------------------------------------------------------------------

REPOS_LLVM          = http://llvm.org/svn/llvm-project/llvm/trunk
REPOS_CLANG         = http://llvm.org/svn/llvm-project/cfe/trunk
REPOS_CRT           = http://llvm.org/svn/llvm-project/compiler-rt/trunk

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
all: llvm_co clang_co crt_co llvm_build

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: llvm_build

# Cleans the build files
clean:
	@echo "    *** Cleaning all build files"
	@$(RM) $(ARGS_RM) $(DIR_BUILD)*
	@$(RM) $(ARGS_RM) $(DIR_LLVM)*

# LLVM checkout
llvm_co:
	@echo "    *** Checking out LLVM sources"
	@if [ ! -d $(DIR_LLVM) ]; then $(SVN) $(ARGS_SVN_CO) $(REPOS_LLVM) $(DIR_LLVM); else $(SVN) $(ARGS_SVN_UP) $(DIR_LLVM); fi

# Clang checkout
clang_co:
	@echo "    *** Checking out Clang sources"
	@if [ ! -d $(DIR_CLANG) ]; then $(SVN) $(ARGS_SVN_CO) $(REPOS_CLANG) $(DIR_CLANG); else $(SVN) $(ARGS_SVN_UP) $(DIR_CLANG); fi

# CRT checkout
crt_co:
	@echo "    *** Checking out CRT sources"
	@if [ ! -d $(DIR_CRT) ]; then $(SVN) $(ARGS_SVN_CO) $(REPOS_CRT) $(DIR_CRT); else $(SVN) $(ARGS_SVN_UP) $(DIR_CRT); fi

# LLVM build
llvm_build:
	@echo "    *** Building LLVM toolchain"
	@$(CD) $(DIR_BUILD) && ../$(DIR_LLVM)configure --enable-optimized
	@$(CD) $(DIR_BUILD) && $(MAKE)
