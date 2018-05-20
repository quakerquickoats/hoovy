//
// Nova
//
// (c) 2018 Lyndon Tremblay
//

#include <stdio.h>
#include <SDL2/SDL.h>

SDL_Window* window = NULL;
//SDL_Surface* screen = NULL;

int screen_width = 512,
  screen_height = 512;

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

void NV_Init (int w, int h)
{
  if (window)
	return;
  
  if (SDL_Init(SDL_INIT_VIDEO) < 0)
	NV_Error("SDL could not initialize! SDL_Error: %s\n", SDL_GetError());

  screen_width = w;
  screen_height = h;
  window = SDL_CreateWindow("SDL Tutorial", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
							screen_width, screen_height, SDL_WINDOW_SHOWN);
  if (!window)
	NV_Error("Window could not be created! SDL_Error: %s\n", SDL_GetError());

  //screen = SDL_GetWindowSurface(window);
}

void NV_Shutdown ()
{
  //SDL_FreeSurface(screen);
  //screen = NULL;

  SDL_DestroyWindow(window);
  window = NULL;
  
  SDL_Quit();
}

int NV_Update ()
{
  SDL_Event e;

  SDL_Delay(200);
  
  while (SDL_PollEvent(&e) != 0)
  {
	if (e.type == SDL_QUIT)
	  return 0;
	else if (e.type == SDL_KEYDOWN) {
	  //Select surfaces based on key press
	  switch (e.key.keysym.sym)
	  {
		case SDLK_q:
		  return 0;
		  break;
	  default:
		printf("asdasodasiodj key\n");
		break;
	  }
	}
  }

  return 1;
}

void NV_Render ()
{
  printf("adsdsd ok...\n");
    screen = SDL_GetWindowSurface(window);

  SDL_FillRect(screen, NULL, SDL_MapRGB(screen->format, 0xFF, 0xFF, 0xFF));
  SDL_UpdateWindowSurface(window);
}

