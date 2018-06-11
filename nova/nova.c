//
// Nova
//
// (c) 2018 Lyndon Tremblay
//

#include <stdio.h>
#include <SDL2/SDL.h>
#include <GL/gl.h>

SDL_Window* window = NULL;
SDL_GLContext context = NULL;
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
  window = SDL_CreateWindow("Nova",
							0, 0,//SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
							screen_width, screen_height,
							SDL_WINDOW_OPENGL|SDL_WINDOW_SHOWN);
  if (!window)
	NV_Error("Window could not be created! SDL_Error: %s\n", SDL_GetError());

  context = SDL_GL_CreateContext(window);
  
  //SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 2);
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 1);
  SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
  SDL_GL_SetSwapInterval(1);

  glViewport(0, 0, screen_width, screen_height);
  //glClearColor(0.0, 0.0, 0.0, 1.0);
  //glClear(GL_COLOR_BUFFER_BIT);
}

void NV_Shutdown ()
{
  SDL_GL_DeleteContext(context);
  context = NULL;

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

void NV_EndFrame ()
{
  printf("adsdsd ok...\n");
  SDL_GL_SwapWindow(window);
}

