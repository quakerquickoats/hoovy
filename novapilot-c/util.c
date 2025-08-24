//
// Novapilot
//
// (c) 2022 Lyndon Tremblay
//

#include <stdarg.h>

#include "novapilot.h"

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
    
    //NV_Shutdown();
    exit(1);
}

FILE *NV_OpenFile (char *fileName)
{
    FILE *f = fopen(fileName, "r");
    return f;
}

BOOL NV_GetToken (FILE *f, char *token)
{
    static int look = 0;    //must be int, to check for EOF
    int index = 0;
    BOOL got = NO;
    
    while (is_space(look))
        look = fgetc(f);
    
    if (is_parens(look))
    {
        token[index++] = (char)look;
        look = fgetc(f);
        got = YES;
    }
    else
    {
        while(look != EOF && !is_space(look) && !is_parens(look))
        {
            token[index++] = (char)look;
            look = fgetc(f);
            got = YES;
        }
    }
    token[index] = '\0';
    return got;
}
