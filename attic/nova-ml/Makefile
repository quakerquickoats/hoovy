BUILD=_build

NOVATOP=$(BUILD)/novatop
NOVATOP_STUB=$(BUILD)/novatop_stub

#RAYLIB=/usr/ocal/lib/libraylib.so
#RAYLIB=`ocamlfind query raylib`/libraylib.so
RAYLIB=/Users/lyndon/.opam/5.3.0/lib/raylib/raylib.a

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
