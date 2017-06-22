EMACS=emacs
EMACS_SRC=/c/Users/Quaker/Downloads/emacs
CFLAGS=-std=gnu99 -ggdb3 -Wall -I$(EMACS_SRC)/src
LDFLAGS=

# On MS-Windows, say "make SO=dll" to build the module
SO      = so
# -fPIC is a no-op on Windows, but causes a compiler warning
ifneq ($(SO),dll)
CFLAGS += -fPIC
endif

all: nova.$(SO)

%.$(SO): %.o
	$(LD) -shared $(LDFLAGS) -o $@ $<

%.o: %.c
	$(CC) $(CFLAGS) -c $<

check:
	$(EMACS) -L . -batch -l ert -l test.el -f ert-run-tests-batch-and-exit
