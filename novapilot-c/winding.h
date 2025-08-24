#ifndef __NOVA_WINDING_H
#define __NOVA_WINDING_H

#include <raylib.h>
#include <rlgl.h>

#include "nova-math.h"

typedef struct
{
    Vector2 v;
    Vector2 t;
    Vector4 c;
}step_t;

//void CopyStep (step_t *a, step_t *b);
//#define NewStep(x, y, t, c) (step_t){.v = {x, y}; .t = t; .color = c}

#define NewStep(x, y) (step_t){.v = {x,y}, .t = {0, 0}, .c = {1, 1, 1, 1}}

#if 0
inline step_t Step (scalar_t x, scalar_t y)
{
    step_t s = { 
        .v = {x, y}, 
        .t = {0, 0}, 
        .c = {1, 1, 1, 1}
    };

    return s;
}
#endif

typedef struct winding_t
{
    struct winding_t *prev, *next;
    int nsteps;
    step_t steps[8];
}winding_t;

void W_Render (winding_t *w);
void W_Scale (winding_t *w, float s);
void W_Union (winding_t *w, float s);
bool W_IsPointInside (winding_t *w, Vector2 point);

winding_t *W_Create (int nsteps, step_t *steps);
winding_t *W_AddStep (winding_t *w, step_t *step);
void W_RenderWire (winding_t *w);

#endif
