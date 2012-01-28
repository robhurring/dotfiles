My Dotfiles.
============

This is a compilation of my env scripts and config along with pieces from other people which I thought were awesome.

Theres some pretty awesome features on the ZSH side:

![zsh screenshot](https://raw.github.com/robhurring/dotfiles/master/.images/zsh-screenshot.png)

Theres not as many command line features for bash, but it is still pretty smooth :)

![bash screenshot](https://raw.github.com/robhurring/dotfiles/master/.images/bash-screenshot.png)

Customizing ZSH
----------------

For ZSH copy the localrc.example to ~/.localrc, you can change the prompt color too if you want (good to set different machines apart as I'm not a huge
fan of having the user/host in my PS1)

Set `PROMPT_COLOR='colorname'` in ~/.localrc to change it:

![colors!](https://raw.github.com/robhurring/dotfiles/master/.images/zsh-colors.png)

You can also configure how RVM's statusline is displayed (with or without the current ruby version) by setting `RVMLONG` to 0 for no version information or 1 (default).

![colors!](https://raw.github.com/robhurring/dotfiles/master/.images/zsh-rvm-status.png)

Customizing Bash
-----------------

Bash has the same thing, only it uses ~/.mybashrc as its local config. You can also edit the PS1 color by editing the function `__before_ps1()`
and changing `PROMPT_COLOR="\e[33;1m"` to any color you want. There is also an ERROR_COLOR too which is red by default.
