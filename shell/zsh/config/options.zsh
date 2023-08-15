zplug "willghatch/zsh-saneopt"

# 16.2.1 Changing Directories
setopt auto_cd           # If a command isn't valid, but is a directory, cd to that dir.
setopt auto_pushd        # Make cd push the old directory onto the dirstack.
setopt cdable_vars       # Change directory to a path stored in a variable.
setopt pushd_ignore_dups # Don't push multiple copies of the same directory onto the dirstack.
setopt pushd_minus       # Exchanges meanings of +/- when navigating the dirstack.
setopt pushd_silent      # Do not print the directory stack after pushd or popd.
setopt pushd_to_home     # Push to home directory when no argument is given.
DIRSTACKSIZE=5

# General options
setopt combining_chars      # Combine 0-len chars with the base character (eg: accents).
setopt interactive_comments # Enable comments in interactive shell.
setopt rc_quotes            # Allow 'Hitchhikers''s Guide' instead of 'Hitchhikers'\''s Guide'.
setopt NO_mail_warning      # Don't print a warning message if a mail file has been accessed.
setopt NO_beep              # Don't Beep on error in line editor.

# Expansion and Globbing
setopt extended_glob     # Use extended globbing syntax.
setopt glob_dots         # Don't hide dotfiles from glob patterns.
setopt no_rm_star_silent # Ask for confirmation for `rm *' or `rm path/*'

# Input/Output
setopt NO_clobber # Don't overwrite files with >. Use >| to bypass.

# Scripts and Functions
setopt multios # Write to multiple descriptors.

# Job options
setopt long_list_jobs # List jobs in the long format by default.
setopt auto_resume    # Attempt to resume existing job before creating a new process.
setopt notify         # Report status of background jobs immediately.
setopt NO_bg_nice     # Don't run all background jobs at a lower priority.
setopt NO_hup         # Don't kill jobs on shell exit.
setopt NO_check_jobs  # Don't report on jobs when shell exit.
setopt no_auto_menu   # Require an extra TAB press to open the completion menu

# Use built-in paste magic.
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Allow [ or ] whereever you want
unsetopt nomatch
