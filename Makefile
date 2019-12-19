all: bpfmap-src ubpf-src

bpfmap-src:
	cd bpfmap && $(MAKE)
	
ubpf-src: bpfmap-src
	cd ubpf && $(MAKE)

clean:
	cd bpfmap && $(MAKE) clean
	cd ubpf && $(MAKE) clean