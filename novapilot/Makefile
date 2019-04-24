TARGET=novapilot
SOURCES=novapilot.ml nova.ml
LIBS=
#OBJECTS=

#include OCamlMakefile

all: $(TARGET)
	@

$(TARGET): build_libnova
	ocamlbuild -use-ocamlfind 'novapilot.native' \
		-package ctypes,ctypes.foreign \
		-lflag -cclib -lflag -lGL \
		-lflag -cclib -lflag -L./nova -lflag -cclib -lflag -lnova

build_libnova:
	make -C ./nova

#	ocamlfind ocamlopt -linkpkg -package ctypes,ctypes.foreign $(SOURCES)
	    #-lflag -cclib -lflag -lGL
