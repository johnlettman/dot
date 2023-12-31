# Make less the default pager, add some options and enable syntax highlight using source-highlight
[ -n "$LESSPIPE" ] && export LESSOPEN="| ${LESSPIPE} %s"

less_options=(
    # If the entire text fits on one screen, just show it and quit. (Be more
    # like "cat" and less like "more".)
    --quit-if-one-screen

    # Do not clear the screen first.
    --no-init

    # Like "smartcase" in Vim: ignore case unless the search pattern is mixed.
    --ignore-case

    # Do not automatically wrap long lines.
    --chop-long-lines

    # Allow ANSI colour escapes, but no other escapes.
    --RAW-CONTROL-CHARS

    # Do not ring the bell when trying to scroll past the end of the buffer.
    --quiet

    # Do not complain when we are on a dumb terminal.
    --dumb
)

export LESS="${less_options[*]}"
export PAGER='less'

# Highlighting inside manpages and elsewhere
export LESS_TERMCAP_mb="\e'[01;31m'"       # begin blinking
export LESS_TERMCAP_md="\e'[01;38;5;74m'"  # begin bold
export LESS_TERMCAP_me="\e'[0m'"           # end mode
export LESS_TERMCAP_se="\e'[0m'"           # end standout-mode
export LESS_TERMCAP_so="\e'[38;5;246m'"    # begin standout-mode - info box
export LESS_TERMCAP_ue="\e'[0m'"           # end underline
export LESS_TERMCAP_us="\e'[04;38;5;146m'" # begin underline
