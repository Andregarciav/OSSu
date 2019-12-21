CFLAGS := -I../ubpf/inc -I../bpfmap

all: ossu

ossu: ossu.o
	$(CC) $(CFLAGS) -c $<
	$(AR) cr ossu.a ossu.o
	

clean:
	$(RM) *.o