DEFAULT_PACKAGES= \
	PostgreSQL \
	dig \
	emacs \
	git \
	less \
	lldb \
	tcsh \
	tmux

all:: stow

stow::
	stow -v -R -d $(HOME)/src/dotfiles -t $(HOME) $(DEFAULT_PACKAGES)

unstow::
	stow -v -D -d $(HOME)/src/dotfiles -t $(HOME) $(DEFAULT_PACKAGES)
