all::

# On Linux: env FETCH=curl make update
FETCH?=fetch
FETCH_ARG?=-o

update:: \
	auto-compile.el \
	auto-complete.el \
	discover.el \
	filladapt.el \
	git-gutter+.el \
	go-autocomplete.el \
	go-eldoc.el \
	go-errcheck.el \
	go-guru.el \
	go-mode.el \
	go-rename.el \
	golint.el \
	google-c-style.el \
	graphviz-dot-mode.el \
	hcl-mode.el \
	highlight-beyond-fill-column.el \
	js2-mode.el \
	lineno.el \
	markdown-mode \
	org-mode \
	protobuf-mode.el \
	solarized-definitions.el \
	terraform-mode.el \
	yafolding.el

# https://github.com/tarsius/auto-compile
auto-compile.el::
	emacs -Q --batch -f toggle-debug-on-error \
		--eval "(require 'package)" \
		--eval "(setq package-archives '((\"melpa\" .  \"https://melpa.org/packages/\")))" \
		--eval "(package-initialize)" \
		--eval "(package-refresh-contents)" \
		--eval "(package-install 'auto-compile)"

# https://github.com/auto-complete/auto-complete
auto-complete.el::
	emacs -Q --batch -f toggle-debug-on-error \
		--eval "(require 'package)" \
		--eval "(setq package-archives '((\"melpa\" .  \"https://melpa.org/packages/\")))" \
		--eval "(package-initialize)" \
		--eval "(package-refresh-contents)" \
		--eval "(package-install 'auto-complete)"

# Source: https://github.com/sellout/emacs-color-theme-solarized
solarized-definitions.el::
	$(FETCH) $(FETCH_ARG) $@ 'https://raw.githubusercontent.com/sellout/emacs-color-theme-solarized/master/solarized-definitions.el'
	$(FETCH) $(FETCH_ARG) ../themes/solarized-theme.el 'https://raw.githubusercontent.com/sellout/emacs-color-theme-solarized/master/solarized-theme.el'
	emacs -Q -batch -L . \
			-f batch-byte-compile \
			../themes/solarized-theme.el $@


# https://github.com/magnars/dash.el
dash.el::
	emacs -Q --batch -f toggle-debug-on-error \
		--eval "(require 'package)" \
		--eval "(setq package-archives '((\"melpa\" .  \"https://melpa.org/packages/\")))" \
		--eval "(package-initialize)" \
		--eval "(package-refresh-contents)" \
		--eval "(package-install 'dash)"

# https://github.com/mickeynp/discover.el
discover.el::
	emacs -Q --batch -f toggle-debug-on-error \
		--eval "(require 'package)" \
		--eval "(setq package-archives '((\"melpa\" .  \"https://melpa.org/packages/\")))" \
		--eval "(package-initialize)" \
		--eval "(package-refresh-contents)" \
		--eval "(package-install 'discover)"

# https://www.emacswiki.org/emacs/FillAdapt
filladapt.el::
	$(FETCH) $(FETCH_ARG) $@ 'http://www.wonderworks.com/download/filladapt.el'
	emacs -Q -batch -L . -f batch-byte-compile $@

flycheck.el::
	emacs -Q --batch -f toggle-debug-on-error \
		--eval "(require 'package)" \
		--eval "(setq package-archives '((\"melpa\" .  \"https://melpa.org/packages/\")))" \
		--eval "(package-initialize)" \
		--eval "(package-refresh-contents)" \
		--eval "(package-install 'flycheck)"

# https://github.com/nonsequitur/git-gutter-plus
git-gutter+.el::
	emacs -Q --batch -f toggle-debug-on-error \
		--eval "(require 'package)" \
		--eval "(setq package-archives '((\"melpa\" .  \"https://melpa.org/packages/\")))" \
		--eval "(package-initialize)" \
		--eval "(package-refresh-contents)" \
		--eval "(package-install 'git-gutter+)"

# https://github.com/google/styleguide
google-c-style.el::
	$(FETCH) $(FETCH_ARG) $@ 'https://raw.githubusercontent.com/google/styleguide/gh-pages/google-c-style.el'
	emacs -Q -batch -L . -f batch-byte-compile $@

# https://github.com/nsf/gocode
gocode::
	go get -u github.com/nsf/gocode

go-autocomplete.el:: auto-complete.el go-mode.el gocode
	$(FETCH) $(FETCH_ARG) $@ 'https://raw.githubusercontent.com/nsf/gocode/master/emacs/go-autocomplete.el'
	emacs -Q -batch -L . \
		--eval "(require 'package)" \
		--eval "(package-initialize)" \
		--eval "(require 'go-mode)" \
		-f batch-byte-compile $@

go-eldoc.el::
	emacs -Q --batch -f toggle-debug-on-error \
		--eval "(require 'package)" \
		--eval "(setq package-archives '((\"melpa\" .  \"https://melpa.org/packages/\")))" \
		--eval "(package-initialize)" \
		--eval "(package-refresh-contents)" \
		--eval "(package-install 'go-eldoc)"

# https://github.com/dominikh/go-errcheck.el
go-errcheck::
	go get -u github.com/kisielk/errcheck

go-errcheck.el:: go-errcheck
	$(FETCH) $(FETCH_ARG) $@ 'https://raw.githubusercontent.com/dominikh/go-errcheck.el/master/go-errcheck.el'
	emacs -Q -batch -L . -f batch-byte-compile $@

# https://godoc.org/golang.org/x/tools/cmd/guru
go-guru::
	go get -u golang.org/x/tools/cmd/guru

go-guru.el:: go-guru go-mode.el
	cd $(GOPATH)/src/golang.org/x/tools/cmd/guru && \
	emacs -Q -batch -L $(HOME)/.emacs.d/lisp -L . \
		--eval "(require 'package)" \
		--eval "(package-initialize)" \
		--eval "(require 'go-mode)" \
		-f batch-byte-compile $@

godef::
	go get -u github.com/rogpeppe/godef

goimport::
	go get -u golang.org/x/tools/cmd/goimports

golint::
	go get -u github.com/golang/lint/golint

goflymake::
	go get -u github.com/dougm/goflymake

# /Users/sean/go/src/github.com/golang/lint/misc/emacs/golint.el
golint.el:: golint go-mode.el
	cd $(GOPATH)/src/github.com/golang/lint/misc/emacs/ && \
	emacs -Q -batch -L $(HOME)/.emacs.d/lisp -L . \
			--eval "(require 'package)" \
			--eval "(package-initialize)" \
			--eval "(require 'go-mode)" \
			-f batch-byte-compile $@

# https://github.com/dominikh/go-mode.el
go-mode.el:: goimport godef goflymake
	emacs -Q --batch -f toggle-debug-on-error \
		--eval "(require 'package)" \
		--eval "(setq package-archives '((\"melpa\" .  \"https://melpa.org/packages/\")))" \
		--eval "(package-initialize)" \
		--eval "(package-refresh-contents)" \
		--eval "(package-install 'go-mode)"

gorename::
	go get -u golang.org/x/tools/refactor/rename

go-rename.el:: gorename
	cd $(GOPATH)/src/golang.org/x/tools/refactor/rename && \
	emacs -Q -batch -L $(HOME)/.emacs.d/lisp -L . \
			--eval "(require 'package)" \
			--eval "(package-initialize)" \
			--eval "(require 'go-mode)" \
			-f batch-byte-compile $@

# https://raw.githubusercontent.com/ncrohn/emacs/master/vendor/emacs-goodies-el/graphviz-dot-mode.el
graphviz-dot-mode.el::
	$(FETCH) $(FETCH_ARG) $@ 'https://raw.githubusercontent.com/ncrohn/emacs/master/vendor/emacs-goodies-el/graphviz-dot-mode.el'
	emacs -Q -batch -L . -f batch-byte-compile $@

# https://github.com/syohex/emacs-hcl-mode
hcl-mode.el::
	emacs -Q --batch -f toggle-debug-on-error \
		--eval "(require 'package)" \
		--eval "(setq package-archives '((\"melpa\" .  \"https://melpa.org/packages/\")))" \
		--eval "(package-initialize)" \
		--eval "(package-refresh-contents)" \
		--eval "(package-install 'hcl-mode)"

# https://github.com/ncrohn/emacs/tree/master/vendor/emacs-goodies-el
highlight-beyond-fill-column.el::
	$(FETCH) $(FETCH_ARG) $@ 'https://raw.githubusercontent.com/ncrohn/emacs/master/vendor/emacs-goodies-el/highlight-beyond-fill-column.el'
	emacs -Q -batch -L . -f batch-byte-compile $@

js2-mode.el::
	emacs -Q --batch -f toggle-debug-on-error \
		--eval "(require 'package)" \
		--eval "(setq package-archives '((\"melpa\" .  \"https://melpa.org/packages/\")))" \
		--eval "(package-initialize)" \
		--eval "(package-refresh-contents)" \
		--eval "(package-install 'js2-mode)"

# https://www.emacswiki.org/emacs/lineno.el
lineno.el::
	$(FETCH) $(FETCH_ARG) $@ 'https://www.emacswiki.org/emacs/download/lineno.el'
	emacs -Q -batch -L . -f batch-byte-compile $@

# https://github.com/defunkt/markdown-mode
markdown-mode::
	emacs -Q --batch -f toggle-debug-on-error \
		--eval "(require 'package)" \
		--eval "(setq package-archives '((\"melpa\" .  \"https://melpa.org/packages/\")))" \
		--eval "(package-initialize)" \
		--eval "(package-refresh-contents)" \
		--eval "(package-install 'markdown-mode)"

# http://orgmode.org/elpa.html
org-mode::
	emacs -Q --batch -f toggle-debug-on-error \
		--eval "(require 'package)" \
		--eval "(setq package-archives '((\"org\" .  \"http://orgmode.org/elpa/\")))" \
		--eval "(package-initialize)" \
		--eval "(package-refresh-contents)" \
		--eval "(package-install 'org-plus-contrib)"

# https://github.com/google/protobuf
protobuf-mode.el::
	$(FETCH) $(FETCH_ARG) $@ 'https://raw.githubusercontent.com/google/protobuf/master/editors/protobuf-mode.el'
	patch -V none -p0 < protobuf-mode.el.patch
	emacs -Q -batch -L . -f batch-byte-compile $@

terraform-mode.el::
	emacs -Q --batch -f toggle-debug-on-error \
		--eval "(require 'package)" \
		--eval "(setq package-archives '((\"melpa\" .  \"https://melpa.org/packages/\")))" \
		--eval "(package-initialize)" \
		--eval "(package-refresh-contents)" \
		--eval "(package-install 'terraform-mode)"

# https://github.com/zenozeng/yafolding.el
yafolding.el::
	$(FETCH) $(FETCH_ARG) $@ 'https://raw.githubusercontent.com/zenozeng/yafolding.el/master/yafolding.el'
	emacs -Q -batch -L . -f batch-byte-compile $@
