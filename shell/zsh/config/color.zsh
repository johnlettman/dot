# make color constants available
autoload -Uz colors && colors

# colorize most commands
zplug "zpm-zsh/colorize"

# enable color output from multiple standard tools in BSD-based systems
export CLICOLOR=1
