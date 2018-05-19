#ECL_CONFIG=/mingw32/ecl-config
#ECL_CFLAGS=-$(shell $(ECL_CONFIG) --cflags)
#ECL_LDFLAGS=`$(ECL_CONFIG) --ldflags`
#ECL_CFLAGS=-I/msys32/mingw32
#ECL_LDFLAGS=-L/msys32/mingw32 -lecl

#CFILES=nova-ecl.c
#TARGET_REPL=nova.exe
TARGET=nova.so
TARGET_REPL=nova-ecl
TARGET_EMACS_MODULE=enova.so

OBJECTS=nova.o

GCC=gcc
EMACS=emacs
EMACS_SOURCES=/home/lyndon/src/emacs/src/
CFLAGS=-s -Wall -Wextra -O3 -fPIC -ggdb3
MODULE_SUFFIX := $(shell $(EMACS) -batch --eval '(princ module-file-suffix)')

all: $(TARGET)
# $(TARGET_REPL) $(TARGET_EMACS_MODULE)
	@

$(TARGET): $(OBJECTS)
	$(GCC) -shared $(CFLAGS) -o $@ $< -lSDL2

$(TARGET_REPL): $(OBJECTS) nova-ecl.o
	$(GCC) -o $@ $< $(ECL_CFLAGS) $(ECL_LDFLAGS) -lecl

$(TARGET_EMACS_MODULE): $(OBJECTS) nova-emacs.o
	$(GCC) -shared $(CFLAGS) -o $@ $^

%.o: %.c
	$(GCC) $(CFLAGS) -I$(EMACS_SOURCES) -o $@ -c $<

clean:
	rm $(OUTPUT) $(EMACS_MODULE)


