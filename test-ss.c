// /opt/local/lib/csv10.3.0/ta6osx/
//
// gcc -o test-ss test-ss.c /opt/local/lib/csv10.3.0/ta6osx/libkernel.a


// this one:
//
// gcc -o test-ss test-ss.c -L/opt/local/lib/csv10.3.0/ta6osx/ -lkernel -ldl -lz -lncurses -liconv -L/opt/local/lib -llz4

#include <stddef.h>
#include <stdio.h>
#include "/opt/local/lib/csv10.3.0/ta6osx/scheme.h"

int _main (int argc, const char**argv)
{
	Sscheme_init(NULL);

	Sregister_boot_file("/opt/local/lib/csv10.3.0/ta6osx/petite.boot");
	Sregister_boot_file("/opt/local/lib/csv10.3.0/ta6osx/scheme.boot");

	Sbuild_heap(NULL, NULL);

	Sscheme_start(argc, argv);
	return 0;
}

/////

#include <stdlib.h>
#include <signal.h>

#define CALL0(who) Scall0(Stop_level_value(Sstring_to_symbol(who)))
#define CALL1(who, arg) Scall1(Stop_level_value(Sstring_to_symbol(who)), arg)

static void custom_init(void)
{
	signal(255, SIG_IGN);
	printf("asdfadfasdf INIT.\n");
}

int main(int argc, char *argv[]) {
  int n, new_argc = 1, ignoreflags = 0;
  ptr p;

  Sscheme_init(NULL);

  #if 0
 /* process command-line arguments, registering boot and heap files */
  for (n = 1; n < argc; n += 1) {
    if (!ignoreflags && *argv[n] == '-') {
      switch (*(argv[n]+1)) {
        case '-': /* pass through remaining options */
          if (*(argv[n]+2) != 0) break;
          ignoreflags = 1;
          continue;
        case 'b': /* boot option, expects boot file pathname */
          if (*(argv[n]+2) != 0) break;
          if (++n == argc) {
            (void) fprintf(stderr,"\n-b option requires argument\n");
            exit(1);
          }
          Sregister_boot_file(argv[n]);
          continue;
        default:
          break;
      }
    }
    argv[new_argc++] = argv[n];
  }
  #endif

  	Sregister_boot_file("/opt/local/lib/csv10.3.0/ta6osx/petite.boot");
	Sregister_boot_file("/opt/local/lib/csv10.3.0/ta6osx/scheme.boot");


 /* must call Sscheme_heap after registering boot and heap files
  * Sscheme_heap() completes the initialization of the Scheme system
  * and loads the boot or heap files.  Before loading boot files,
  * it calls custom_init(). */
  Sbuild_heap(NULL, custom_init);

  for (;;) {
      CALL1("display", Sstring("* "));
      p = CALL0("read");
      if (Seof_objectp(p)) { printf("ooooops?\n"); break; }
      p = CALL1("eval", p);
      if (p != Svoid) CALL1("pretty-print", p);
  }
  CALL0("newline");

 /* must call Scheme_deinit after saving the heap and before exiting */
  Sscheme_deinit();

  exit(0);
}
