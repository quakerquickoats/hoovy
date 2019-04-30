#include <stdio.h>
#include <SWI-Prolog.h>

//extern foreign_t pl_lowercase(term, term);

static foreign_t
pl_say_hello(term_t to)
{
    char *a;

    printf("tries..\n");
    
    if (PL_get_atom_chars(to, &a)) {
        printf("Hello: %s\n", a);
        PL_succeed;
    }
    
    PL_fail;
}

PL_extension predicates[] =
{
/*{ "name",      arity,  function,      PL_FA_<flags> },*/

    { "lowercase", 1,       pl_say_hello,  0 },
    { NULL,        0,      NULL,           0 }
};

int
main(int argc, char **argv)
{
    PL_register_extensions(predicates);

    if (!PL_initialise(argc, argv))
        PL_halt(1);
  
    printf("Gunzip OK.\n");

    PL_halt(PL_toplevel() ? 0 : 1);
}
