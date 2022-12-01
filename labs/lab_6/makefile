.PHONY: clean
CC=gcc
CFLAGS=-I$(IDIR)

IDIR=/opt/opencl/include
LIBR=OpenCL
%.o: %.c $(DEPS)
	%(CC) -c -o $@ $< $(CFLAGS)

all: matrixmul_host matrixMul deviceQuery clDeviceQuery

matrixmul_host: matrixmul_host.c
	$(CC) -o $@ $^ $(CFLAGS) -l$(LIBR)

matrixMul: matrixMul.c
	$(CC) -o $@ $^ $(CFLAGS) -l$(LIBR)

deviceQuery: deviceQuery.c
	$(CC) -o $@ $^ $(CFLAGS) -l$(LIBR)

clDeviceQuery: clDeviceQuery.cpp
	g++ -o $@ $^ $(CFLAGS) -l$(LIBR) 

clean:
	rm -f *.o lab_6 matrixmul_host matrixMul deviceQuery clDeviceQuery