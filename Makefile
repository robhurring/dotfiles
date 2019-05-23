# Makefile for servers which only installs the minimum dotfiles for comfort
# without the ruby dependency. For the full experience use the rake tasks
CWD=$(shell pwd)

# Dotfiles
ETC=$(shell ls ./etc)
DOTFILES=$(ETC:%=$(HOME)/.%)

# XDG
XDG_CONFIG_HOME:=$(HOME)/.config
XDG_CACHE_HOME:=$(HOME)/.cache
XDG_DATA_HOME:=$(HOME)/.local/share

CONFIG=$(shell ls ./config)
XDGFILES=$(CONFIG:%=$(XDG_CONFIG_HOME)/%)

# Binfiles
BIN=$(shell ls ./bin)
BINFILES=$(BIN:%=$(HOME)/bin/%)

ZHOME:=$(XDG_CONFIG_HOME)/zsh

# Link etc & bin
all: .setup $(DOTFILES) $(XDGFILES) $(BINFILES) zsh
	@echo "All good."

mac: all kitty tmux fzf brew
	@echo "Done!"

kitty: $(HOME)/Library/Preferences/kitty/kitty.conf

$(HOME)/Library/Preferences/kitty/kitty.conf:
	mkdir -p $(dir $@)
	ln -sfv $(XDG_CONFIG_HOME)/kitty/kitty.conf $@

update:
	-git pull
	$(MAKE) all

.setup:
	@mkdir -p $(HOME)/bin
	@mkdir -p $(XDG_CONFIG_HOME) && chmod 740 $(XDG_CONFIG_HOME)
	@mkdir -p $(XDG_CACHE_HOME) && chmod 740 $(XDG_CACHE_HOME)
	@mkdir -p $(XDG_DATA_HOME) && chmod 740 $(XDG_DATA_HOME)


zsh: $(HOME)/.zshenv $(HOME)/.zshrc $(HOME)/.zprofile

tmux: $(HOME)/.tmux

fzf: $(HOME)/.fzf

$(HOME)/.fzf:
	@git clone https://github.com/junegunn/fzf.git $(HOME)/.fzf
	@$(HOME)/.fzf/install

$(HOME)/.tmux:
	@mkdir -p $(HOME)/.tmux/plugins
	@git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm
	@$(HOME)/.tmux/plugins/tpm/bin/install_plugins

$(HOME)/.zshrc:
	@echo "zsh:	.zshrc"
	@if [ -e $@ ]; then mv $@ $@.old; fi
	@cp -i $(ZHOME)/templates/zshrc $@

$(HOME)/.zprofile:
	@echo "zsh:	.zprofile"
	@if [ -e $@ ]; then mv $@ $@.old; fi
	@cp -i $(ZHOME)/templates/zprofile $@

$(HOME)/.zshenv:
	@echo "zsh:	.zshenv"
	@if [ -e $@ ]; then mv $@ $@.old; fi
	@cp -i $(ZHOME)/templates/zshenv $@
	@chmod 640 $@

# link ETC files
$(HOME)/.%: $(CWD)/etc/%
	@echo "linking:	$< -> $@"
	@ln -sf $< $@

# link XDG_CONFIG files
$(HOME)/.config/%: $(CWD)/config/%
	@echo "linking:	$< -> $@"
	@ln -sf $< $@

# link bin files
$(HOME)/bin/%: $(CWD)/bin/%
	@echo "bin:		$< -> $@"
	@ln -sf $< $@

brew:
	@type brew || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	@brew bundle check || brew bundle

iterm:
	tic $(XDG_CONFIG_HOME)/iterm2/xterm-256color-italic.terminfo
	tic $(XDG_CONFIG_HOME)/iterm2/screen-256color-italic.terminfo
	tic $(XDG_CONFIG_HOME)/iterm2/screen-256color.terminfo

.PHONY: all mac extra .setup zsh tmux brew iterm kitty
