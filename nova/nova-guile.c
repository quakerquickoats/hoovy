//
// Nova
//
// (c) 2018 Lyndon Tremblay
//

#include <libguile.h>

void init_nova ()
{
    scm_c_define_gsubr();
}

static void inner_main (void *closure, int argc, char **argv)
{
    scm_shell(argc, argv);
}

int main (int argc, char **argv)
{
    scm_boot_guile(argc, argv, inner_main, 0);
    return 0;
}
