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
BREW_APPS=ag

all: .setup $(DOTFILES) $(BINFILES) .zsh .tmux
	@echo "All good."

clean:
	rm -rf $(DOTFILES)
	rm -rf $(BINFILES)
	rm -rf ~/.zsh
	rm -rf ~/.tmux

# only relevant for OSX
fonts: $(FONTFILES)
	@echo "Fonts installed."

# only relevant for OSX
apps: .brew $(BREW_APPS) $(GUI_APPS)

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
	@brew cask install $@

$(BREW_APPS):
	@echo "installing: $<"
	@brew install $@

.brew:
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew install caskroom/cask/brew-cask

.PHONY: $(GUI_APPS)
