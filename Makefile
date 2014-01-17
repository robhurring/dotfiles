# Makefile for servers which only installs the minimum dotfiles for comfort
# without the ruby dependency. For the full experience use the rake tasks
CWD=$(shell pwd)

ETC = ackrc gemrc irbrc pryrc rdebugrc tigrc tmux.conf
DOTFILES=$(ETC:%=$(HOME)/.%)

BIN = ack battery-status git-branch-time git-wtf weather
BINFILES=$(BIN:%=$(HOME)/bin/%)

all: $(DOTFILES) .bin .zsh .vim
	git submodule update --init --recursive
	vim +BundleInstall +qall
	@echo "All good."

clean:
	rm -rf $(DOTFILES)
	rm -rf $(BINFILES)
	rm -rf ~/.zsh ~/.zshrc
	rm -rf ~/.vim ~/.vimrc ~/.vimrc.bundles ~/.vimrc.local

.zsh: $(HOME)/.zsh $(HOME)/.zshrc
.vim: $(HOME)/.vim $(HOME)/.vimrc $(HOME)/.vimrc.bundles
.bin: $(HOME)/bin $(BINFILES)

# link ETC files
$(HOME)/.%: $(CWD)/etc/%
	@echo "linking:	$< -> $@"
	@ln -sf $< $@

# make sure we have a bin
$(HOME)/bin:
	@mkdir -p $@

# link bin files
$(HOME)/bin/%: $(CWD)/bin/%
	@echo "bin:		$< -> $@"
	@ln -sf $< $@

# zshrc example
$(HOME)/.zshrc:
	@echo "zsh:	.zshrc"
	@if [ -e $@ ]; then mv $@ $@.old; fi
	@cp -i $(CWD)/example/zshrc $@

# link our zsh shell files
$(HOME)/.zsh:
	@echo "zsh:	.zsh"
	@ln -sf $(CWD)/shells/zsh $@

# link our vimrc
$(HOME)/.vimrc:
	@echo "vim:	.vimrc"
	@if [ -e $@ ]; then mv $@ $@.old; fi
	@ln -si $(CWD)/shells/vim/etc/vimrc $@

# link our vimrc bundle
$(HOME)/.vimrc.bundles:
	@echo "vim:	.vimrc.bundles"
	@if [ -e $@ ]; then mv $@ $@.old; fi
	@ln -si $(CWD)/shells/vim/etc/vimrc.bundles $@

# link our vim files
$(HOME)/.vim:
	@echo "vim:	.vim"
	@ln -sf $(CWD)/shells/vim $@

.PHONY: install