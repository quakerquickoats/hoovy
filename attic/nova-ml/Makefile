BUILD=_build

NOVATOP=$(BUILD)/novatop
NOVATOP_STUB=$(BUILD)/novatop_stub

RAYLIB=/usr/ocal/lib/libraylib.so

all: $(NOVATOP)

$(NOVATOP):
	ocamlmktop -custom -o $@ \
	-thread -verbose \
	-dllib $(RAYLIB) -cclib "-lraylib"

$(NOVATOP_STUB): $(BUILD)/stub.o
	ocamlmktop -custom -o $@ \
	-thread -verbose \
	-dllib $(RAYLIB) -cclib "-lraylib" $<

$(BUILD)/stub.o:
	ocaml raylib_stubs.ml -o $@ -package ctypes.foreign
