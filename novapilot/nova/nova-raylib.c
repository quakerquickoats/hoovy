//
// Nova
//
// (c) 2018 Lyndon Tremblay
//

#include "nova.h"
#include <GL/gl.h>
#include <raylib.h>

nova_session_t nova = {
                       512, 512
                        };



void NV_Init (int w, int h)
{
    nova.width = w;
    nova.height = h;
    InitWindow(nova.width, nova.height, "Nova");
    SetTargetFPS(60);
    glViewport(0, 0, nova.width, nova.height);
}

void NV_Shutdown ()
{
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
