//
// Novapilot
//
// (c) 2022 Lyndon Tremblay
//

#include "novapilot.h"

#include <string.h>

game_state_t game =
{
    // 2:1 aspect
    .config = { 1024, 512 },
    //.config = { 1280, 640 }
    .camera = { 0 },
    .editing = true,

    .objects = NULL
};

game_edit_t edit =
{
    .cursor = {0, 0}
    
};

void KeyMove (Vector2 *v, float scale)
{
    if (IsKeyPressed(KEY_A))
        v->x -= 1*scale;
    else if (IsKeyPressed(KEY_D))
        v->x += 1*scale;
    if (IsKeyPressed(KEY_W))
        v->y -= 1*scale;
    else if (IsKeyPressed(KEY_S))
        v->y += 1*scale;
}

void Edit ()
{
    KeyMove(&edit.cursor, 1);
    //dupe
    if (IsKeyDown(KEY_LEFT))
        game.camera.target.x -= 3;
    if (IsKeyDown(KEY_RIGHT))
        game.camera.target.x += 3;
    if (IsKeyDown(KEY_UP))
        game.camera.target.y -= 3;
    if (IsKeyDown(KEY_DOWN))
        game.camera.target.y += 3;
    
    if (edit.winding && edit.winding->nsteps > 1)
    {
        step_t *last = edit.winding->steps + (edit.winding->nsteps-1);
        if (last)
        {
            last->v.x = edit.cursor.x;
            last->v.y = edit.cursor.y;
        }
    }

    if (IsKeyPressed(KEY_SPACE))
    {
        if (edit.winding)
        {
            winding_t *w = edit.winding;
            step_t *s = w->steps + w->nsteps;
            memset(s, 0, sizeof(step_t));
            s->v.x = edit.cursor.x;
            s->v.y = edit.cursor.y;
            w->nsteps += 1;
            printf("OK add. %f %f\n", edit.cursor.x, edit.cursor.y);
        }
        else
        {
            step_t a = NewStep(edit.cursor.x, edit.cursor.y);
            step_t b = NewStep(edit.cursor.y, edit.cursor.y);
            step_t s[] = {a,b};
                    
            edit.winding = W_Create(2, s);
            printf("OK make\n");
        }
    }
    else if (IsKeyPressed(KEY_BACKSPACE))
    {
        printf("try remove\n");
    }
    else if (IsKeyPressed(KEY_ENTER))
    {
        if (edit.winding)
        {
            AddToList(game.windings, edit.winding);
            //game.windings = edit.winding;
            edit.winding = NULL;
        }
    }
    else if (IsKeyPressed(KEY_ESCAPE))
    {
        free(edit.winding);
        edit.winding = NULL;
        printf("OK clear.\n");
    }
    else if (IsKeyPressed(KEY_MINUS))
        game.camera.zoom -= 0.1;
    else if (IsKeyPressed(KEY_EQUAL))
        game.camera.zoom += 0.1;
            
    BeginMode2D(game.camera);
    // draw grid
    DrawRectangleLines(-(GameWidth/2), -(GameWidth/2), GameWidth, GameWidth, RED);
    int x = 0, y = 0;
    for (x=-(GameWidth/2) ; x<GameWidth/2 ; x += 16)
    {
        for (y=-(GameWidth/2) ; y<GameHeight/2 ; y += 16)
        {
            DrawLine(x, y, x+(GameWidth/2), y, GREEN);
            DrawLine(x, y, x, y+(GameHeight/2), BLUE);
        }    
    }

    DrawRectangleLines((edit.cursor.x*16)-8, (edit.cursor.y*16)-8, 16, 16, YELLOW);
    if (edit.winding)
        W_RenderWire(edit.winding);

}

void Play ()
{
    object_t *p = game.player;
    KeyMove(&p->vel, 3);

    Vector2 vel = {0, 0};
    bool shoot = false;
    

    if (IsKeyPressed(KEY_APOSTROPHE))
    {
        vel.x = 1;
        shoot = true;
    }
    if (IsKeyPressed(KEY_L))
    {
        vel.x = -1;
        shoot = true;
    }
    if (IsKeyPressed(KEY_P))
    {
        vel.y = -1;
        shoot = true;
    }
    else if (IsKeyPressed(KEY_SEMICOLON))
    {
        vel.y = 1;
        shoot = true;
    }
    
    if (shoot)
    {
        object_t *b = O_Create(OBJ_BULLET, NULL);
        b->pos = game.player->pos;
        b->vel = Vector2Normalize(vel);
        b->vel = Vector2Scale(vel, 20);
        AddToList(game.objects, b);
    }
    
#if 0
    if (p->vel.x > 0.01)
        p->vel.x /= 2;
    else
        p->vel.x = 0;

    if (p->vel.y > 0.01)
        p->vel
#endif
}

int main (int argc, char **argv)
{
    SetTraceLogLevel(LOG_WARNING);  //LOG_INFO  // LOG_NONE
    InitWindow(game.config.width, game.config.height, "Novapilot");
    
    SetTargetFPS(30);  // 60
    SetExitKey(KEY_Q);
    
    printf("Novapilot Init.\n");

    ////////////////////
    game.camera.target = (Vector2){0, 0};
    game.camera.offset = (Vector2){GameWidth/2, GameHeight/2};
    game.camera.rotation = 0;
    game.camera.zoom = 1;

    game.player = O_Create(OBJ_PLAYER, NULL);
    game.objects = game.player;
    game.windings = NULL;
    
    while (!WindowShouldClose())
    {
        BeginDrawing();
        ClearBackground(BLACK);

        if (game.editing)
            Edit();
        else
            Play();
        
        BeginMode2D(game.camera);
        for (winding_t *w=game.windings ; w ; w=w->next)
        {
            W_RenderWire(w);
        }

        //object_t *newList = NULL;
        for (object_t *o=game.objects ; o ; o=o->next)
        {
            if (!game.editing)
                if (O_Update(o))
                    ;//AddToList(newList, o);
            O_Render(o);
        }
        EndMode2D();
        
        if (IsKeyPressed(KEY_TAB))
            game.editing = !game.editing;

        // object count
        char str[256];
        int nobj;
        object_t *o;
        for (nobj=0,o=game.objects ; o ; o=o->next, nobj++)
            sprintf(str, "%i OBJ", nobj);
        DrawText(str, 100, 100, 20, ORANGE);
        EndMode2D();

        DrawFPS(10, 10);
        EndDrawing();
    }

    CloseWindow();
    return 0;
}


#if 0
    //////////// parse test
    FILE *f = fopen("test.nv", "r");
    char token[1024];
    while (NV_GetToken(f, token))
    {
        printf("token: %s\n", token);
        getchar();
    }
    fclose(f);
#endif
