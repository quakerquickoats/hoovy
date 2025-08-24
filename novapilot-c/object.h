#ifndef __NOVAPILOT_OBJECT_H
#define __NOVAPILOT_OBJECT_H

typedef struct key_t
{
    struct keyval_t *prev, *next;
    char key[32];
    char value[];
}keyval_t;

keyval_t *KV_New (char *key, char *value);
keyval_t *KV_CloneDict (keyval_t *dict);

////////////////////////

typedef enum
{
    OBJ_PLAYER = 1,
    OBJ_BULLET = 2,
    OBJ_ENEMY = 3,
    OBJ_HEALTH = 4,
}ObjectClass;


typedef struct object_t
{
    ObjectClass class;
    Vector2 pos;
    Vector2 vel;

    int hp;
    float life;

    int tag;
    keyval_t *dict;

    struct object_t *prev, *next;
}object_t;

object_t *O_Create (ObjectClass c, keyval_t *dict);
bool O_Update (object_t *o);
void O_Render (object_t *o);

#define AddToList(list, o) \
    if (list) { \
        list->prev = o; \
        o->next = list; \
        list = o; } \
    else                \
        list = o;    // strange, we get 'expected expression' if we put the assign outside the elseif.

#endif
