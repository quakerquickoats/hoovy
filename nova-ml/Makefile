RESULT     = novapilot
SOURCES    = nova.ml
LIBS       = bigarray tsdl gg ecl
#INCDIRS    = +tsdl
#CFLAGS = -cclib -lecl

#include OCamlMakefile


all:
	ocamlbuild -use-ocamlfind 'novapilot.native' -lflag -cclib -lflag -lecl

all22:
	ocamlbuild -use-ocamlfind 'novapilot.cmo'
	ocamlfind ocamlmktop -o novapilot -thread -linkpkg -package utop -package tsdl novapilot.cmo


nothing:
	ocamlfind ocamlc -o novapilot -thread -linkpkg -linkall -predicates create_toploop \
       -package compiler-libs.toplevel,utop novapilot.cmo
