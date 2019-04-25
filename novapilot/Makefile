RESULT     = novapilot
SOURCES    = main.ml
LIBS       = bigarray gg
#INCDIRS    = +tsdl
#CFLAGS = -cclib -lecl

#include OCamlMakefile


all:
	ocamlbuild -use-ocamlfind 'novapilot.native' -lflag -cclib -lflag -L.

#all22:
#	ocamlbuild -use-ocamlfind 'novapilot.cmo'
#	ocamlfind ocamlmktop -o novapilot -thread -linkpkg -package ctypes -package ctypes.foreign -package utop -package tsdl novapilot.cmo


nothing:
	ocamlfind ocamlc -o novapilot -thread -linkpkg -linkall -predicates create_toploop \
       -package compiler-libs.toplevel,utop novapilot.cmo
