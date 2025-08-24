TARGETS = novapilot

OBJECTS = util.o winding.o object.o novapilot.o

#CC=gcc
CC=clang
CFLAGS=-Wall -g -fPIC -ggdb -I/usr/local/include
LDFLAGS=-L/usr/local/lib -lraylib

all: $(TARGETS)
	@

$(TARGETS): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $<

clean:
	rm $(TARGETS) $(OBJECTS)
#	rm $(TARGETS) $(OBJECTS)

BKDATE=$(shell date)
backup:
	echo $(BKDATE)
