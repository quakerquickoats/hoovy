//
// Novapilot
//
// (c) 2022 Lyndon Tremblay
//

#include "winding.h"

#include <stdlib.h>
#include <string.h>

winding_t *W_Create (int nsteps, step_t *steps)
{
    winding_t *w = malloc(sizeof(winding_t));// + (sizeof(step_t)*nsteps));
    //w->next = w->prev = NULL;
    memset(w, 0, sizeof(winding_t));

    if (nsteps > 0 && steps)
    {
        memcpy(w->steps, steps, sizeof(step_t)*nsteps);
    }
    w->nsteps = nsteps;
    return w;
}


winding_t *W_AddStep (winding_t *w, step_t *step)
{
    //winding_t *new = W_Create(w->nsteps + 1, NULL);
    //memcpy(new->steps, w->steps, sizeof(step_t) * w->nsteps);
    //memcpy(new->steps + (new->nsteps-1), step, sizeof(step_t));
    //// memcpy...
    //return new;

    memcpy(w->steps + w->nsteps, step, sizeof(step_t));
    w->nsteps += 1;
    return w;
}

void W_Render (winding_t *w)
{
    if (!w)
        return;

    rlSetLineWidth(2);
    rlColor3f(1, 1, 1);
    
//    rlEnableTexture(w.texID);
    rlBegin(RL_LINES);
    for (int i = 0; i < w->nsteps; i++)
    {
        step_t *s = w->steps + i;
        
        //rlTexCoord2f(0.5, 0.5);
        rlVertex2f(s->v.x, s->v.y);
    }
    rlEnd();
//    rlDisableTexture();
}

#if 1
void W_RenderWire (winding_t *w)
{
    if (!w)
        return;

    for (int i=0 ; i < w->nsteps ; i++)
    {
        step_t *s = w->steps + i, *n;
        if (i == w->nsteps-1)
            n = w->steps;
        else
            n = w->steps + i + 1;
        
        DrawLine(s->v.x*16, s->v.y*16, n->v.x*16, n->v.y*16, YELLOW);
    }
}
#else
    
void W_RenderWire (winding_t *w)
{
    if (!w)
        return;

    rlSetLineWidth(2);
    rlColor3f(0, 1, 1);
    
    rlBegin(RL_LINES);
    for (int i = 0; i < w->nsteps; i++)
    {
        step_t *s = w->steps + i;
        rlVertex2f(s->v.x, s->v.y);
    }
    rlEnd();
}
#endif
