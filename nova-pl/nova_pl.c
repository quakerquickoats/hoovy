#include <stdio.h>
#include <SWI-Prolog.h>

static foreign_t
pl_say_hello(term_t t)
{
  char *a;
  if (PL_get_atom_chars(t, &a))
  {
	printf("adsfasdfasdfas : %s\n", a);
	PL_succeed;
  }

  PL_fail;
}

install_t
install_nova()
{
  PL_register_foreign("say_hello", 1, pl_say_hello, 0);
}

