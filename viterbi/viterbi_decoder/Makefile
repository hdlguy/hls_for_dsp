# Makefile
CXX = g++

BINS = viterbi_decoder_tb
SRCS = viterbi_decoder_tb.cpp
CPPFLAGS = -I/tools/Xilinx_vitis/Vivado/2019.2/include/

all: $(BINS)

clean:
	$(RM) *.o $(BINS)

viterbi_decoder.o: viterbi_decoder.cpp viterbi_decoder.h
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $<

viterbi_decoder_tb.o: viterbi_decoder_tb.cpp viterbi_decoder.h
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $<

viterbi_decoder_tb: viterbi_decoder_tb.o viterbi_decoder.o 
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $^ -o $@

.PHONY: all clean test


