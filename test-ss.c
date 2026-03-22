// /opt/local/lib/csv10.3.0/ta6osx/
//
// gcc -o test-ss test-ss.c /opt/local/lib/csv10.3.0/ta6osx/libkernel.a


// this one:
//
// gcc -o test-ss test-ss.c -L/opt/local/lib/csv10.3.0/ta6osx/ -lkernel -ldl -lz -lncurses -liconv -L/opt/local/lib -llz4

#include <stddef.h>
#include <stdio.h>
#include "/opt/local/lib/csv10.3.0/ta6osx/scheme.h"

int main (int argc, const char**argv)
{
	Sscheme_init(NULL);

	Sregister_boot_file("/opt/local/lib/csv10.3.0/ta6osx/petite.boot");
	Sregister_boot_file("/opt/local/lib/csv10.3.0/ta6osx/scheme.boot");

	Sbuild_heap(NULL, NULL);

	Sscheme_start(argc, argv);
	return 0;
}
