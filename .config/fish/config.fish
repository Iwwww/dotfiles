if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x EDITOR "nvim"
set -x VISUAL "nvim"
set -x TERMINAL "/usr/local/bin/st"

# IntelliShell
set -gx INTELLI_HOME /home/mikhail/.local/share/intelli-shell
# set -gx INTELLI_SEARCH_HOTKEY \cr
# set -gx INTELLI_LABEL_HOTKEY \cl
# set -gx INTELLI_BOOKMARK_HOTKEY \cb
# set -gx INTELLI_SKIP_ESC_BIND 0
source "$INTELLI_HOME/bin/intelli-shell.fish"
