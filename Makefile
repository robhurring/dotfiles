# Makefile for servers which only installs the minimum dotfiles for comfort
# without the ruby dependency. For the full experience use the rake tasks
CWD=$(shell pwd)

ETC=$(shell ls ./etc)
DOTFILES=$(ETC:%=$(HOME)/.%)

BIN=$(shell ls ./bin)
BINFILES=$(BIN:%=$(HOME)/bin/%)

FONTS=$(shell ls ./other/fonts)
FONTFILES=$(FONTS:%=$(HOME)/Library/Fonts/%)

all: .setup $(DOTFILES) $(BINFILES) .zsh
	@echo "All good."

fonts: $(FONTFILES)
	@echo "Fonts installed."

clean:
	rm -rf $(DOTFILES)
	rm -rf $(BINFILES)
	rm -rf ~/.zsh

.setup:
	@mkdir -p $HOME/bin

.zsh: $(HOME)/.zsh $(HOME)/.zshrc

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
