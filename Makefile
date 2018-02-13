# Makefile for servers which only installs the minimum dotfiles for comfort
# without the ruby dependency. For the full experience use the rake tasks
CWD=$(shell pwd)

ETC=$(shell ls ./etc)
DOTFILES=$(ETC:%=$(HOME)/.%)

CONFIG=$(shell ls ./config)
XDGFILES=$(CONFIG:%=$(HOME)/.config/%)

BIN=$(shell ls ./bin)
BINFILES=$(BIN:%=$(HOME)/bin/%)

# Link etc & bin
all: .setup $(DOTFILES) $(XDGFILES)$(BINFILES) .zsh
	@echo "All good."

mac: all extra
	@echo "Done!"

extra: .brew .iterm .tmux .gems .npm

kitty: $(HOME)/Library/Preferences/kitty/kitty.conf

$(HOME)/Library/Preferences/kitty/kitty.conf:
	mkdir -p $(dir $@)
	ln -sfv $(CWD)/other/kitty.conf $@

update:
	-git pull
	$(MAKE) all

.setup:
	@mkdir -p $HOME/bin

.zsh: $(HOME)/.zsh $(HOME)/.zshrc $(HOME)/.zprofile

.tmux: $(HOME)/.tmux

$(HOME)/.tmux:
	@mkdir -p $(HOME)/.tmux/plugins
	@git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm
	@$(HOME)/.tmux/plugins/tpm/bin/install_plugins

$(HOME)/.zprofile:
	@ln -sf $(HOME)/.zshrc $@

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

# zshrc example
$(HOME)/.zshrc:
	@echo "zsh:	.zshrc"
	@if [ -e $@ ]; then mv $@ $@.old; fi
	@cp -i $(CWD)/example/zshrc $@

# link our zsh shell files
$(HOME)/.zsh:
	@echo "zsh:	.zsh"
	@ln -sf $(CWD)/shells/zsh $@

.gems:
	@rvm @global do gem install bundler
	@rvm @global do bundle check || bundle install

.npm:
	@npm install

.brew:
	@type brew || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	@brew bundle check || brew bundle

.iterm:
	tic $(CWD)/other/iterm2/xterm-256color-italic.terminfo
	tic $(CWD)/other/iterm2/screen-256color-italic.terminfo
	tic $(CWD)/other/iterm2/screen-256color.terminfo

.PHONY: all mac extra .setup .zsh .tmux .brew .npm .gems .iterm
