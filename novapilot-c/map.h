typedef struct
{
    int len;
}ring_t;

typedef struct
{
    int nwindings;
    ring_t *windings;
}room_t;

typedef struct
{
    int nrooms;
    room_t rooms[];
}map_t;

