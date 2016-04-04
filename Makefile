# Makefile for servers which only installs the minimum dotfiles for comfort
# without the ruby dependency. For the full experience use the rake tasks
CWD=$(shell pwd)

ETC=$(shell ls ./etc)
DOTFILES=$(ETC:%=$(HOME)/.%)

BIN=$(shell ls ./bin)
BINFILES=$(BIN:%=$(HOME)/bin/%)

FONTS=$(shell ls ./other/fonts)
FONTFILES=$(FONTS:%=$(HOME)/Library/Fonts/%)

# casked apps
GUI_APPS=amethyst
BREW_APPS=ag shellcheck universal-ctags hub git

# Link etc & bin
all: .setup $(DOTFILES) $(BINFILES)
	@echo "All good."

# Install all deps
install: all .zsh .iterm .tmux .gems .npm
	@echo "Done!"

update:
	-git pull
	$(MAKE) all

clean:
	rm -rf $(DOTFILES)
	rm -rf $(BINFILES)
	rm -rf ~/.zsh
	rm -rf ~/.tmux

# only relevant for OSX
fonts: $(FONTFILES)
	@echo "Fonts installed."

# only relevant for OSX
apps: .brew $(BREW_APPS) $(GUI_APPS) .thirdparty

.setup:
	@mkdir -p $HOME/bin

.zsh: $(HOME)/.zsh $(HOME)/.zshrc $(HOME)/.zprofile

.tmux: $(HOME)/.tmux

.iterm:
	tic $(CWD)/other/iterm2/xterm-256color-italic.terminfo
	tic $(CWD)/other/iterm2/screen-256color-italic.terminfo

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

# link bin files
$(HOME)/bin/%: $(CWD)/bin/%
	@echo "bin:		$< -> $@"
	@ln -sf $< $@

# font files
$(HOME)/Library/Fonts/%: $(CWD)/other/fonts/%
	@echo "font:		$< -> $@"
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

$(GUI_APPS):
	@echo "installing: $@"
	-brew cask install $@

$(BREW_APPS):
	@echo "installing: $<"
	-brew upgrade $@

.gems:
	@rvm @global do bundle check || bundle install

.npm:
	@npm install

.brew:
	@ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	-brew tap universal-ctags/universal-ctags
	-brew upgrade caskroom/cask/brew-cask

.thirdparty:
	-pip install vim-vint

.PHONY: $(GUI_APPS) $(BREW_APPS)
