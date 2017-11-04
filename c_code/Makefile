ALL_EXE = main
all: $(ALL_EXE) 

CC=g++
CFLAGS=-I. 

DEPS = Makefile 

PUBLIC_LIBS =
LIB_FILES =

LIB_OBJS := $(subst .c,.o,$(LIB_FILES))

# $@: target file name, $^: all prerequisites
# $<: first prerequisite

main: main.o $(LIB_OBJS) $(PUBLIC_LIBS)
	$(CC) -g -o $@ $^

run: main
	./main

clean:
	rm -rf *.o $(ALL_EXE) 

%.o: %.c $(DEPS)
	$(CC) -g -c -o $@ $< $(CFLAGS)
