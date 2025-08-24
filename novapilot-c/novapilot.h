//
// Novapilot
//
// (c) 2022 Lyndon Tremblay
//

#ifndef _NOVA_H
#define _NOVA_H

#ifndef BOOL
typedef int BOOL;
#endif
#define YES 1
#define NO 0

//#include "nova-math.h"
#include "winding.h"
#include "object.h"

///////////////////////////////////////

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <raylib.h>
#include <raymath.h>
#include <rlgl.h>

#if 0
#ifdef __APPLE__
/* Defined before OpenGL and GLUT includes to avoid deprecation messages */
//#define GL_SILENCE_DEPRECATION
#include <OpenGL/gl.h>
//#include <GLUT/glut.h>
#else
#include <GL/gl.h>
//#include <GL/glut.h>
#endif
#endif

///////////////////////////////////////

/*
typedef enum {
    NV_KEY_UP,
    NV_KEY_DOWN,
    NV_KEY_LEFT,
    NV_KEY_RIGHT
}game_key_t;
*/

#define GameWidth (game.config.width)
#define GameHeight (game.config.height)

typedef struct
{
    int width, height;
}game_config_t;

typedef struct
{
    game_config_t config;   // const on creation

    // temporary, on load.
    bool editing;
    object_t *player;

    // actual state (serialized)
    Camera2D camera;
    object_t *objects;
    winding_t *windings;
}game_state_t;
extern game_state_t game;

typedef struct
{
    Vector2 cursor;
    winding_t *winding;
}game_edit_t;
extern game_edit_t edit;

/////////////////////////////////////////
// util

#define debug(m,e) printf("%s:%d: %s:",__FILE__,__LINE__,m); print_obj(e,1); puts("");
void NV_Error (const char *msg, ...);

typedef struct List {
    struct List * next;
    void * data;
}List;

#define is_space(x)  (x == ' ' || x == '\n')
#define is_parens(x) (x == '(' || x == ')') // || x == '{' || x == '}' || x == '[' || x == ']')
BOOL NV_GetToken (FILE *f, char *token);

/////////////////////////////////////////
// raylib backend (or sdl, emacs, glfw, 3ds...)
//BOOL NV_CheckKey (game_key_t k);


#endif
