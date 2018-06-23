You need a Common Lisp implementation.
   Only tested on SBCL.



1. Link the project into Quicklisp.

   ln -s ~/src/nova-js ~/quicklisp/local-projects

2. Load the project in SLIME or at the REPL.

    sbcl or M-x slime
    > (ql:quickload :nova-js)
    (nova-js:output [dir])   ;; 'dir' is optional

----OR----

1. Link the huma4drl.asd file into your ~/.sbcl/systems directory:

    mkdir ~/.sbcl
    mkdir ~/.sbcl/systems
    ln -s ~/src/nova-js/nova-js.asd ~/.sbcl/systems

2. At the shell, cd to the the directory with this file, run SBCL, and
   then at the REPL, type:

    > (require :nova-js)
    > (in-package :nova-js)
    > (output [dir])               ;; 'dir' is optional destination
