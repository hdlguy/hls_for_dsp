ALL_EXE = main
all: $(ALL_EXE) 

CC=g++
CFLAGS=-I. 

DEPS = Makefile 

PUBLIC_LIBS =
LIB_FILES = main.cpp z.cpp

LIB_OBJS := $(subst .cpp,.o,$(LIB_FILES))

# $@: target file name 
# $<: first prerequisite
# $^: all prerequisites

main: main.o $(LIB_OBJS) $(PUBLIC_LIBS)
	$(CC) -g -o $@ $^

run: main
	./main

clean:
	rm -rf *.o $(ALL_EXE) 

%.o: %.c $(DEPS)
	$(CC) -g -c -o $@ $< $(CFLAGS)
