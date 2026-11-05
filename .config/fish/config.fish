# Put any configuration that should happen even in non-interactive usage here

# The rest of this file shouldn't be run if we're just executing a fish script
if not status is-interactive
    exit
end

# If we're ssh'ed into a machine, and that machine has tmux, and we're not already running TMUX,
# then we almost definitely want to run it
if set --query SSH_TTY; and type --quiet tmux; and not set --query TMUX
    if not tmux has-session
        exec tmux new-session
    end

    exec tmux attach
end

# Some commands that we'll run (e.g. fisher) will invoke fish, causing this file to be processed recursively
# Guard against that situation with an environment variable
if set --query ALREADY_PROCESSING_FISH_CONFIG
    exit
else
    set --export ALREADY_PROCESSING_FISH_CONFIG 1
end

set -g fish_key_bindings fish_vi_key_bindings
set fish_term24bit 1
abbr --add --position command gb git branch -vv
abbr --add --position command gbd git branch -d
abbr --add --position command gbD git branch -D
abbr --add --position command vi emacs --no-window-system
abbr --add --position command vim emacs --no-window-system

if not type --quiet fisher
    echo "Plugins will not be available for fish until fisher is installed"
else
    echo "$(fisher --version), installed plugins:"
    fisher list

    echo ""
    if not type --quiet nvm
        echo "nvm is not installed. Please run fisher update"
    else
        echo "NodeJS versions:"
        nvm ls
    end
end

echo ""
if not type --quiet emacs
    echo "Emacs not installed!"
else
    echo "Emacs: $(emacs --version | head -n 1)"
end

# Clean up guard environment variable
set --erase ALREADY_PROCESSING_FISH_CONFIG 1

echo ""
echo "Available abbreviations:"
abbr --show

echo ""
