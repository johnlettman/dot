#!/usr/bin/env zsh
if [[ -r "${HOME}/.profile" ]]; then
    source "${HOME}/.profile"
fi

function get_current_dir() {
    local trace_info="${funcfiletrace[1]}"
    local sourced_file="$(readlink "${trace_info%:*}")"
    echo "$(dirname "$sourced_file")"
}

# zplug
export ZPLUG_HOME="${HOME}/.zplug"
source "${ZPLUG_HOME}/init.zsh"

#
# Prompt
#
if ! program_exists starship; then
    curl -sS https://starship.rs/install.sh | sh
fi

if [ -r "${HOME}/.starship.toml" ]; then
    export STARSHIP_CONFIG="${HOME}/.starship.toml"
elif [ -r "${HOME}/.config/starship.toml" ]; then
    export STARSHIP_CONFIG="${HOME}/.config/starship.toml"
elif [ -r "$(get_current_dir)/../starship.toml" ]; then
    export STARSHIP_CONFIG="$(get_current_dir)/../starship.toml"
fi

eval "$(starship init zsh)"
zplug "wintermi/zsh-starship", as:plugin

if [[ -d "${HOME}/.config/zsh" ]]; then
    for file in "${HOME}/.config/zsh"/*; do
        # shellcheck disable=SC1090
        source "${file}"
    done
elif [[ -d "$(get_current_dir)/config" ]]; then
    for file in "$(get_current_dir)/config"/*; do
        # shellcheck disable=SC1090
        source "${file}"
    done
fi

#
# Autosuggest
#
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8,underline"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=200

#
# Aliases
#
## Global aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g C='| wc -l'
alias -g H='| head'
alias -g L="| less"
alias -g N="| /dev/null"
alias -g S='| sort'
alias -g G='| grep'

# Tips
zplug "djui/alias-tips"

#
# Git
#
alias git='noglob git'

# Makes git auto completion faster favouring for local completions
__git_files() {
    _wanted files expl 'local files' _files
}

#
# ZMV
#
autoload -Uz zmv
alias zmv="noglob zmv -W"

#
# Syntax highlighting
#
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "fcambus/ansiweather"
append_manpath "${ZPLUG_REPOS}/fcambus/ansiweather"

#
# Last command
#
# Use Ctrl-x,Ctrl-l to get the output of the last command
zmodload -i zsh/parameter
insert-last-command-output() {
    LBUFFER+="$(eval $history[$((HISTCMD - 1))])"
}
zle -N insert-last-command-output
bindkey "^X^L" insert-last-command-output

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
unset zle_bracketed_paste

zplug "mafredri/zsh-async", from:"github", use:"async.zsh"

zplug "zsh-users/zsh-history-substring-search", defer:3

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo
        zplug install
    fi
fi

zplug load
