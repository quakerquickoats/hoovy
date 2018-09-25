//
// Nova
//
// (c) 2018 Lyndon Tremblay
//

#ifndef _NOVA_H
#define _NOVA_H

typedef enum {
              NV_KEY_UP,
              NV_KEY_DOWN,
              NV_KEY_LEFT,
              NV_KEY_RIGHT
}nova_key_t;

#ifndef BOOL
typedef int BOOL;
#endif

void NV_Init ();
void NV_Shutdown ();

void NV_Error (const char *msg, ...);

void NV_EndFrame ();

BOOL NV_Update ();
BOOL NV_CheckKey (nova_key_t k);

#endif
