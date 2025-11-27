#!/usr/bin/env bash

#
# History
#
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/shell/history"
[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# Append history
shopt -s histappend

# De-duplicate
export HISTCONTROL=ignoredups:erasedups

# Zsh time compatibility
export HISTTIMEFORMAT="%F %T "
