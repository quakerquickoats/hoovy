//
// Nova
//
// (c) 2018 Lyndon Tremblay
//

#include <stdio.h>
#include <SDL2/SDL.h>

SDL_Window* window = NULL;
SDL_Surface* screen = NULL;

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

void NV_Init ()
{
  if (SDL_Init(SDL_INIT_VIDEO) < 0)
	NV_Error("SDL could not initialize! SDL_Error: %s\n", SDL_GetError());
}

void NV_Shutdown ()
{
}
