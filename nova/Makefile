#ECL_CONFIG=/mingw32/ecl-config
#ECL_CFLAGS=-$(shell $(ECL_CONFIG) --cflags)
#ECL_LDFLAGS=`$(ECL_CONFIG) --ldflags`
#ECL_CFLAGS=-I/msys32/mingw32
#ECL_LDFLAGS=-L/msys32/mingw32 -lecl

#CFILES=nova-ecl.c
#TARGET_REPL=nova.exe
TARGET_REPL=nova
TARGET_EMACS_MODULE=nova.so

GCC=gcc
EMACS=emacs
CFLAGS=-s -Wall -Wextra -O3 -fPIC -ggdb3 -I/home/lyndon/src/emacs/src/
MODULE_SUFFIX := $(shell $(EMACS) -batch --eval '(princ module-file-suffix)')

all: $(TARGET_REPL) $(TARGET_EMACS_MODULE)
	@

$(TARGET_REPL): nova-ecl.c
	$(GCC) -o $@ $< $(ECL_CFLAGS) $(ECL_LDFLAGS) -lecl

$(TARGET_EMACS_MODULE): nova-emacs.c
	$(GCC) -shared $(CFLAGS) -o $@ $^

%.o: %.c
	$(GCC) -o $@ -c $<

clean:
	rm $(OUTPUT) $(EMACS_MODULE)


