//
// Novapilot
//
// (c) 2022 Lyndon Tremblay
//

#include "novapilot.h"

keyval_t *KV_New (char *key, char *value)
{
    keyval_t *kv = malloc(sizeof(keyval_t) + strlen(value));
    strcpy(kv->key, key);
    strcpy(kv->value, value);
    return kv;
}

keyval_t *KV_CloneDict (keyval_t *dict)
{
    // should actually copy.
    return dict;
}

////////////////////////////////////////////////////////

object_t *O_Create (ObjectClass c, keyval_t *dict)
{
    object_t *o = malloc(sizeof(object_t));

    memset(o, 0, sizeof(object_t));
    o->class = c;
    o->dict = KV_CloneDict(dict);
    
    switch (c)
    {
    case OBJ_PLAYER:
        o->hp = 100;
        o->life = -1;
        break;

    case OBJ_BULLET:
        o->life = 2;
        break;
        
    default:
        o->hp = 0;
        o->life = -1;
        break;
    }

    return o;
}

bool O_Update (object_t *o)
{
    o->pos = Vector2Add(o->pos, o->vel);
    //o->pos.x += o->vel.x;
    //o->pos.y += o->vel.y;

    if (o->class == OBJ_PLAYER || o->class == OBJ_ENEMY)
        o->pos.y += 1;

    if (o->life > 0)
    {
        o->life -= GetFrameTime();
        if (o->life < 0)
            return false;
    }

    return true;
}

void O_Render (object_t *o)
{
    switch (o->class)
    {
    case OBJ_PLAYER:
        DrawRectangleGradientV(o->pos.x, o->pos.y, 16, 16, GREEN, BLUE);
        break;

    case OBJ_BULLET:
        DrawCircle(o->pos.x, o->pos.y, 8, WHITE);
        break;

    default:
        DrawRectangle(o->pos.x, o->pos.y, 16, 16, RED);
        break;
        
    }
}

#if 0
object_t *O_AddToList (object_t *list, object_t *o)
{
    list->prev = o;
    o->next = list;
    return o;
}
#endif
