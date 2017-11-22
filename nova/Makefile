RESULT     = novapilot
SOURCES    = nova.ml
LIBS       = bigarray tsdl
#INCDIRS    = +tsdl

#include OCamlMakefile


all:
	ocamlbuild -use-ocamlfind 'novapilot.native'

all22:
	ocamlbuild -use-ocamlfind 'novapilot.cmo'
	ocamlfind ocamlmktop -o novapilot -thread -linkpkg -package utop -package tsdl novapilot.cmo


nothing:
	ocamlfind ocamlc -o novapilot -thread -linkpkg -linkall -predicates create_toploop \
       -package compiler-libs.toplevel,utop novapilot.cmo
