# Supercharge
zplug "zap-zsh/supercharge"
zplug "zap-zsh/exa"

# ASCIIDoctor Plugin
# https://github.com/sparsick/asciidoctor-zsh
zplug "sparsick/asciidoctor-zsh", defer:2

# Calculator plugin
zplug "arzzen/calc.plugin.zsh"

# Careful `rm` command
zplug "MikeDacre/careful_rm"

# Clipboard
zplug "zpm-zsh/clipboard"

# diff-so-fancy
zplug "z-shell/zsh-diff-so-fancy", as:command, use:"bin/"

# autohjump
zplug "wting/autojump"

# favorite directories
favorite-directories:get() {
    # echo <name> <depth> <path>
    echo repos 2 ~/repos
    echo canonical-repos 2 ~/repos/canonical
}

zplug "seletskiy/zsh-favorite-directories"
bindkey -v '^_' "favorite-directories:cd"
