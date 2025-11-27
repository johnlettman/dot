#!/usr/bin/env zsh
[[ -r "${HOME}/.profile" ]] && source "${HOME}/.profile"

#
# History
#
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/shell/history"
[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"

setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY      # append immediately
setopt SHARE_HISTORY           # share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST  # when trimming history, remove duplicates first
setopt HIST_IGNORE_ALL_DUPS    # never put duplicates in history at all
setopt HIST_FIND_NO_DUPS       # when searching history, don’t show duplicates
setopt HIST_IGNORE_SPACE       # don’t save commands starting with space
setopt HIST_SAVE_NO_DUPS       # don’t write duplicates to the history file
setopt HIST_VERIFY             # don’t execute expanded history immediately

#
# lesspipe
#
has_program lesspipe.sh && { lesspipe.sh | source /dev/stdin; }

#
# zinit bootstrap
#
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[[ ! -d $ZINIT_HOME ]] && mkdir -p "$(dirname $ZINIT_HOME)"
[[ ! -d $ZINIT_HOME/.git ]] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

if [[ -r "${HOME}/.starship.toml" ]]; then
    export STARSHIP_CONFIG="${HOME}/.starship.toml"
elif [[ -r "${HOME}/.config/starship.toml" ]]; then
    export STARSHIP_CONFIG="${HOME}/.config/starship.toml"
elif [[ -r "$(get_current_dir)/../starship.toml" ]]; then
    export STARSHIP_CONFIG="$(get_current_dir)/../starship.toml"
fi

#
# Enable completions
#
autoload -Uz compinit
if [[ ! -f "${HOME}/.zcompdump" ]]; then
    compinit -u
else
    compinit -C -u  # use cache
fi

# fzf-tab
zstyle ':fzf-tab:*' switch-group ',' '.'

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false

# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no

# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:*:*'  fzf-preview '[[ ${commands[$1]} ]] && man $1 2>/dev/null || echo $1'

# custom fzf flags
zstyle ':fzf-tab:*' fzf-flags \
  --color=fg:4,fg+:2 \
  --no-sort \
  --height=~50% \
  --layout=reverse

zstyle ':fzf-tab:*' use-fzf-default-opts yes

zinit light Aloxaf/fzf-tab

# history substring search
zinit light zsh-users/zsh-history-substring-search

# autosuggestions
zinit light zsh-users/zsh-autosuggestions
bindkey '^[[Z' autosuggest-accept
bindkey '^ '  autosuggest-accept

# syntax highlighting
zinit light zdharma-continuum/fast-syntax-highlighting

#
# Plugins
#
zinit light wintermi/zsh-starship           # starship prompt
zinit light MikeDacre/careful_rm            # safer `rm`
zinit snippet OMZL::git.zsh                 # OMZ `git`
zinit snippet OMZP::git                     # OMZ `git`
zinit light ptavares/zsh-direnv             # load `.env` files
zinit light ajeetdsouza/zoxide              # better `cd`
zinit light ael-code/zsh-colored-man-pages  # `man` page colors
zinit light z-shell/zsh-diff-so-fancy       # `diff` colors
zinit snippet OMZP::common-aliases          # OMZ common aliases
zinit snippet OMZP::sudo                    # OMZ `sudo`
zinit light mattberther/zsh-pyenv           # `pyenv` support

#
# eza
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/eza/README.md
#
zstyle ':omz:plugins:eza' 'dirs-first'  "yes"
zstyle ':omz:plugins:eza' 'git-status'  "yes"
zstyle ':omz:plugins:eza' 'header'      "yes"
zstyle ':omz:plugins:eza' 'icons'       "yes"
zstyle ':omz:plugins:eza' 'size-prefix' "binary"
zstyle ':omz:plugins:eza' 'icons'       "yes"
zstyle ':omz:plugins:eza' 'hyperlink'   "yes"
zinit snippet OMZP::eza

#
# Completion style
#
# case-insensitive completion
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

#
# Suggestions
#
zinit load zsh-users/zsh-autosuggestions
bindkey '^[[Z' autosuggest-accept        # [shift]+[tab]
bindkey '^ '  autosuggest-accept         # [ctrl]+[space]

#
# Misc. options
#
setopt AUTO_CD
setopt CORRECT           # command auto-correction
setopt NO_BEEP
setopt INTERACTIVE_COMMENTS
setopt MULTIBYTE
setopt PRINT_EIGHTBIT

#
# Key bindings
#
# Emacs editing mode
bindkey -e

# Word movement
bindkey "^[b"     backward-word
bindkey "^[f"     forward-word
bindkey "^[[1;5D" backward-word # [ctrl]+[←]
bindkey "^[[1;5C" forward-word  # [ctrl]+[→]
bindkey "^[[5D"   backward-word # [ctrl]+[←]
bindkey "^[[5C"   forward-word  # [ctrl]+[→]
bindkey "^[[5^"   backward-word # [ctrl]+[←]
bindkey "^[[5@"   forward-word  # [ctrl]+[→]

# Word deletion
bindkey "^[d" kill-word          # [alt]+D
bindkey "^W"  backward-kill-word # [ctrl]+W

# Word deletion (backspace)
bindkey "^[^?" backward-kill-word # [ctrl]+[backspace]
bindkey "^_"   backward-kill-word # [ctrl]+[backspace]

# Word delection (del)
bindkey "^[[3;5~" kill-word # [ctrl]+[del]

# Home / End
bindkey "^[[1~" beginning-of-line # [home]
bindkey "^[[4~" end-of-line       # [end]
bindkey "^[[H"  beginning-of-line # [home]
bindkey "^[[F"  end-of-line       # [end]
bindkey "^[OH"  beginning-of-line # [home]
bindkey "^[OF"  end-of-line       # [end]

#
# Local customizations
#
[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local
