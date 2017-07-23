#ECL_CONFIG=/mingw32/ecl-config
#ECL_CFLAGS=-$(shell $(ECL_CONFIG) --cflags)
#ECL_LDFLAGS=`$(ECL_CONFIG) --ldflags`
ECL_CFLAGS=-I/msys32/mingw32
ECL_LDFLAGS=-L/msys32/mingw32 -lecl

CFILES=game.c
OUTPUT=gamelike.exe

all:
	gcc -o $(OUTPUT) $(CFILES) $(ECL_CFLAGS) $(ECL_LDFLAGS)

clean:
	rm $(OUTPUT)
