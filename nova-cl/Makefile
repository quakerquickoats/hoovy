#ECL_CONFIG=/mingw32/ecl-config
#ECL_CFLAGS=-$(shell $(ECL_CONFIG) --cflags)
#ECL_LDFLAGS=`$(ECL_CONFIG) --ldflags`
ECL_CFLAGS=-I/msys32/mingw32
ECL_LDFLAGS=-L/msys32/mingw32 -lecl

CFILES=nova-ecl.c
#OUTPUT=nova.exe
OUTPUT=nova

GCC=gcc
EMACS=emacs
CFLAGS=-s -Wall -Wextra -O3 -fPIC -ggdb3 -I/home/lyndon/Downloads/emacs/src/
MODULE_SUFFIX := $(shell $(EMACS) -batch --eval '(princ module-file-suffix)')
EMACS_MODULE=nova.so

all: $(OUTPUT) $(EMACS_MODULE)
	@

$(OUTPUT):
	$(GCC) -o $(OUTPUT) $(CFILES) $(ECL_CFLAGS) $(ECL_LDFLAGS)

$(EMACS_MODULE): nova-emacs.c
	$(GCC) -shared $(CFLAGS) -o $@ $^

clean:
	rm $(OUTPUT) $(EMACS_MODULE)


