# Makefile for viterbi codec.
#
# Created by: Min Xu <mxu@scu.edu> or <xukmin@gmail.com>
# Date: 01/30/2015

CXX = g++

BINS = main
SRCS = main.cpp
CPPFLAGS = -I/tools/Xilinx_vitis/Vivado/2019.2/include/

all: $(BINS)

clean:
	$(RM) *.o $(BINS)

main.o: main.cpp main.h
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $<

main: main.o 
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $^ -o $@

.PHONY: all clean test

