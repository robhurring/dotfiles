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

tmux: $(XDG_DATA_HOME)/tmux

fzf: $(HOME)/.fzf

$(XDG_DATA_HOME)/tmux:
	@mkdir -p $(XDG_DATA_HOME)/tmux/plugins
	@git clone https://github.com/tmux-plugins/tpm $(XDG_DATA_HOME)/tmux/plugins/tpm
	@$(XDG_DATA_HOME)/tmux/plugins/tpm/bin/install_plugins

$(HOME)/.fzf:
	@git clone https://github.com/junegunn/fzf.git $(HOME)/.fzf
	@$(HOME)/.fzf/install

$(HOME)/.zshrc:
	@echo "zsh:	.zshrc"
	@cp -i $(ZHOME)/templates/zshrc $@
	@chmod 640 $@

$(HOME)/.zprofile:
	@echo "zsh:	.zprofile"
	@cp -i $(ZHOME)/templates/zprofile $@
	@chmod 640 $@

$(HOME)/.zshenv:
	@echo "zsh:	.zshenv"
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

.PHONY: all mac extra .setup zsh tmux brew iterm kitty
