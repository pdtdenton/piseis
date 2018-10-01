

# options for applications


# Options specific for GCC
export CC = gcc
#
export CCFLAGS_BASIC =  -Wall
#
#
#CCFLAGS = $(CCFLAGS_BASIC)
#
# optimized
export CCFLAGS = -O3 $(CCFLAGS_BASIC)
#
# profile
#CCFLAGS= -pg -p $(CCFLAGS_BASIC)
#
# debug - gdb, valgrind, ...
#CCFLAGS = $(CCFLAGS_BASIC) -g
#CCFLAGS = $(CCFLAGS_BASIC) -g -O3
# valgrind --leak-check=yes --dsymutil=yes exe_name <args>
# w/o -O3 : valgrind --leak-check=yes --dsymutil=yes --track-origins=yes exe_name <args>
# valgrind --leak-check=full --show-reachable=yes --dsymutil=yes exe_name <args>
# valgrind --tool=callgrind --dsymutil=yes exe_name <args>  # callgrind_annotate [options] --tree=both --inclusive=yes callgrind.out.<pid>

export PWD = $(shell pwd)
export MYBIN = ${PWD}

# use local libmseed in distribution
export LIB_MSEED = ${PWD}/program/libmseed/libmseed.a

# get operating system
UNAME := $(shell uname)
ifneq ($(UNAME),Darwin)
	export LIB_RT = -lrt	# use for raspberry pi (Linux?), not on Mac OSX (uname = Darwin)
endif

#VPATH = ${PWD}/program/libmseed

PROG_DIR = program/
LIBRARIES = \
	libmseed
	
MODULES = \
	mini_logger_writer \
	ringserver

all:

	@for x in $(LIBRARIES); \
	do \
		(echo ------; cd ${PROG_DIR}$$x; echo Making $@ in:; pwd; \
		make -f Makefile;); \
	done
	@for x in $(MODULES); \
	do \
		(echo ------; cd ${PROG_DIR}$$x; echo Making $@ in:; pwd; \
		make -f Makefile); \
	done

	@cp program/ringserver/ringserver ${PWD}
	@echo
	@echo "PWD ${PWD}"
	@echo "MYBIN ${MYBIN}"
	@echo

clean:
	@for x in $(LIBRARIES); \
	do \
		(cd ${PROG_DIR}$$x; echo Cleaning in:; pwd; \
		make -f Makefile clean); \
	done
	@for x in $(MODULES); \
	do \
		(cd ${PROG_DIR}$$x; echo Cleaning in:; pwd; \
		make -f Makefile clean); \
	done
