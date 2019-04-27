//
// Nova
//
// (c) 2019 Lyndon Tremblay
//

#ifndef _NOVA_H
#define _NOVA_H

//typedef float scalar;

#ifndef BOOL
typedef int BOOL;
#endif
#define YES 1
#define NO 0

///////////////////////////////////////

typedef enum {
    NV_KEY_UP,
    NV_KEY_DOWN,
    NV_KEY_LEFT,
    NV_KEY_RIGHT
}nova_key_t;

typedef struct {
    int width, height;
}nova_config_t;

typedef struct {
    nova_config_t config;   // const on creation
    BOOL keys[16];
}nova_session_t;

extern nova_session_t nova;

/////////////////////////////////////////
// util

void NV_Error (const char *msg, ...);

/////////////////////////////////////////
// sdl or raylib

void NV_Init (int width, int height);
void NV_Shutdown ();

void NV_EndFrame ();

BOOL NV_Update ();
BOOL NV_CheckKey (nova_key_t k);

#endif
