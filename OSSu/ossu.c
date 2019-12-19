#include <stdio.h>
#include <stdlib.h>

#include "ubpf.h"
#include "bpfmap.h"

struct ubpf_vm *vm;
int main(int argc,char *argv[]){
    struct ubpf_vm *vm = ubpf_create();
    if (!vm) {
        fprintf(stderr, "Failed to create VM\n");
        return 1;
    }
}