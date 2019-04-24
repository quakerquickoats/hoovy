//
// Nova
//
// (c) 2018 Lyndon Tremblay
//

#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>

void NV_Error (const char *msg, ...)
{
    va_list args;
    //char buf[256];

    va_start(args, msg);
    //vsprintf(buf, "Nova Error: %s",
    fprintf(stderr, "Nova Error: ");
    fflush(stderr);
    vfprintf(stderr, msg, args);
    va_end(args);
    fprintf(stderr, "\n");
    
    exit(1);
}

