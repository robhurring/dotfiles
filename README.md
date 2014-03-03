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

### vim Install

This has been moved to [https://github.com/robhurring/dotvim](https://github.com/robhurring/dotvim) to keep it separate.

## Customizing ZSH

See `~/.zsh/themes/default` for how to configure this theme

![colors!](https://raw.github.com/robhurring/dotfiles/master/.images/zsh-colors.png)

And when using git + rvm

![colors!](https://raw.github.com/robhurring/dotfiles/master/.images/zsh-rvm-status.png)

## Customizing Bash

**Note: This is old and I have no idea if this will even work well anymore**

Edit ~/.bashrc before the init line to set the colors. You can also edit the PS1 color by editing the function `__before_ps1()`
and changing `PROMPT_COLOR="\e[33;1m"` to any color you want. There is also an `ERROR_COLOR` too which is red by default.
