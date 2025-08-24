#ifndef __NOVAMATH_H
#define __NOVAMATH_H

#if 0
typedef double scalar_t;

typedef scalar_t v2[2];
typedef scalar_t v3[3];
typedef scalar_t v4[4];

////////////////////////////////

inline void _v2add (v2 a, v2 b, v2 c)
{
    c[0] = a[0] + b[0];
    c[1] = a[1] + b[1];
}

////////////////////////////////

inline void _V3add (v3 a, v3 b, v3 c)
{
    c[0] = a[0] + b[0];
    c[1] = a[1] + b[1];
    c[2] = a[2] + c[2];
}
#endif
////////////////////////////////

#define v2add(a,b,c)

#endif
