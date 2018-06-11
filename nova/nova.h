//
// Nova
//
// (c) 2018 Lyndon Tremblay
//

#ifndef _NOVA_H
#define _NOVA_H

void NV_Init ();
void NV_Shutdown ();

void NV_Error (const char *msg, ...);

void NV_EndFrame ();

#endif
