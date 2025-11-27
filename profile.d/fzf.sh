#!/bin/sh
if has_program fd; then
    export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"
    export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
    export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git"
elif has_program fdfind; then
    alias fd=fdfind
    export FZF_DEFAULT_COMMAND="fdfind --type f --hidden --exclude .git"
    export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
    export FZF_ALT_C_COMMAND="fdfind --type d --hidden --exclude .git"
fi
