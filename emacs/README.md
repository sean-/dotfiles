# emacs

See the `GNUmakefile` in `.emacs.d/lisp` for a list of `make` targets to
fetch and install various packages.  The following two steps are all that
should be necessary:

1. `make -C .emacs.d/lisp update`
2. `make -C .emacs.d compile`

Many of the `emacs` packages don't compile, but certainly enough do that it
makes a big performance benefit.
