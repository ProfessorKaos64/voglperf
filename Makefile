#
# Simple makefile which simply launches cmake in the appropriate directories and make.
#
#   ; builds native version
#   make
#
#   ; builds 32 and 64-bit versions
#   make voglperf32 voglperf64
#

UNAME := $(shell uname -i)

all: voglperfnative

voglperfnative:
	@mkdir -p build_$(UNAME); cd build_$(UNAME); cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE=true ../src; make

voglperf64:
	@mkdir -p build64; cd build64; cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_X64=True -DCMAKE_VERBOSE=true ../src; make

voglperf32:
	@mkdir -p build32; cd build32; cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_X64=False -DCMAKE_VERBOSE=true ../src; make

clean:
	@rm -rf build64
	@rm -rf build32
	@rm -rf lib/libvoglperf* 
	@rm -rf bin/voglperfrun*

.PHONY: all voglperfnative voglperf32 voglperf64 clean

