all: ossu

ossu: bpfmap-src ubpf-src
	cd OSSu && $(MAKE)

bpfmap-src:
	cd bpfmap && $(MAKE)
	
ubpf-src: bpfmap-src
	cd ubpf && $(MAKE)

clean:
	cd bpfmap && $(MAKE) clean
	cd ubpf && $(MAKE) clean
	cd OSSu && $(MAKE) clean