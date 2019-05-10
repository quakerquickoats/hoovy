//
// Nova
//
// (c) 2018 Lyndon Tremblay
//

#include "nova.h"
#include <GL/gl.h>
#include <raylib.h>

nova_session_t nova = {
    // config
    { 512, 512 }
};


void NV_Init (int w, int h)
{
    nova_config_t *c = &nova.config;
    memset(&nova, 0, sizeof(nova));
        
    c->width = w;
    c->height = h;
    InitWindow(c->width, c->height, "Nova");
    SetTargetFPS(30);  // 60
    glViewport(0, 0, c->width, c->height);
}

void NV_Shutdown ()
{
    memset(&nova, 0, sizeof(nova));
    CloseWindow();
}

BOOL NV_Update ()
{
    BOOL end = WindowShouldClose();
    BeginDrawing();
    return !end;
}

void NV_EndFrame ()
{
    EndDrawing();
}
