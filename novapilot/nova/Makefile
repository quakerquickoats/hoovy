TARGET=nova.so

#OBJECTS=nova-sdl.o
OBJECTS=nova-raylib.o nova-util.o

GCC=gcc
#CFLAGS=-s -Wall -Wextra -O3 -fPIC -ggdb3
CFLAGS=-Wall -g -fPIC

#LDFLAGS=-lSDL2
LDFLAGS=-lraylib

all: $(TARGET)
	@

#################

$(TARGET): $(OBJECTS)
	$(GCC) -shared $(CFLAGS) -o $@ $< $(LDFLAGS)

##################

%.o: %.c
	$(GCC) $(CFLAGS) -o $@ -c $<

clean:
	rm $(TARGET) $(OBJECTS)


