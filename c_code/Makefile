all: main

CC=g++
CFLAGS=-I./ -I/opt/Xilinx/Vivado/2017.3/include/

# $@: target file name 
# $<: first prerequisite
# $^: all prerequisites

main: main.o z.o
	$(CC) -g -o $@ $^

run: main
	./main

clean:
	rm -rf *.o $(ALL_EXE) 

main.o: main.cpp z.hpp Makefile
	$(CC) -g -c -o $@ $< $(CFLAGS)

z.o: z.cpp z.hpp Makefile
	$(CC) -g -c -o $@ $< $(CFLAGS)
