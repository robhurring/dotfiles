# My Dotfiles.

This is a compilation of my env scripts and config along with pieces from other people which I thought were awesome.

Heres how it looks when using ZSH:

![zsh screenshot](https://raw.github.com/robhurring/dotfiles/master/.images/zsh-screenshot.png)

And heres how it looks when using BASH: (outdated so may not be the same)

![bash screenshot](https://raw.github.com/robhurring/dotfiles/master/.images/bash-screenshot.png)

## Install

clone this repo somewhere `git clone https://github.com/robhurring/dotfiles.git` (i use ~/.dotfiles)

*note:* The installers are safe and will ask before overwriting any existing files.

### ZSH Install

1. cd ~/.dotfiles (or wherever repo lives)
2. `rake zsh` to link zsh env files
3. `cp ~/.dotfiles/example/zshrc ~/.zshrc`
  1. modify the example zshrc paths for `DOTFILES`
  2. add any customizations below the init line

### Bash Install

1. cd ~/.dotfiles (or wherever repo lives)
2. `rake bash` to link zsh env files
3. `cp ~/.dotfiles/example/bashrc ~/.bashrc`
  1. modify the example bashrc paths for `DOTFILES`
  2. add any customizations below the init line

### oh-my-zsh Install

Experimental, but there is a `rake omz` task that will link up the custom plugins/themes

### vim Install

1. cd ~/.dotfiles (or wherever repo lives)
2. update submodules
3. `rake vim` to link vimrc and ~/.vim
4. `vim +:BundleInstall` to install bundles

## Customizing ZSH

See `~/.zsh/themes/default` for how to configure this theme

![colors!](https://raw.github.com/robhurring/dotfiles/master/.images/zsh-colors.png)

And when using git + rvm

![colors!](https://raw.github.com/robhurring/dotfiles/master/.images/zsh-rvm-status.png)

## Customizing Bash

Edit ~/.bashrc before the init line to set the colors. You can also edit the PS1 color by editing the function `__before_ps1()`
and changing `PROMPT_COLOR="\e[33;1m"` to any color you want. There is also an `ERROR_COLOR` too which is red by default.
