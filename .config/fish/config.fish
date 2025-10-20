# Note: This file assumes that the .zshrc from this same dotfiles repo has already run.
# Specifically, that means that brew is installed and up-to-date

# Put any configuration that should happen even in non-interactive usage here


# The rest of this file shouldn't be run if we're just executing a fish script
if not status is-interactive
    exit
end

# I think most fish configuration will go here
# We're in an interactive shell, possibly running in tmux
set -g fish_key_bindings fish_vi_key_bindings
set fish_term24bit 1
abbr --add --position command gb git branch -vv

# The rest of this file shouldn't be run if we're opening a new fish shell from within tmux
if set --query TMUX
    exit
end

# Some commands that we'll run (e.g. fisher) will invoke fish, causing this file to be processed recursively
# Guard against that situation with an environment variable
if set --query ALREADY_PROCESSING_FISH_CONFIG
    exit
end

set --export ALREADY_PROCESSING_FISH_CONFIG 1

# Install wezterm terminfo if not already installed
if not toe -a | grep --quiet wezterm
    echo "[config.fish] START Installing wezterm terminfo file"
    set --local tempfile $(mktemp)
    curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo
    tic -x -o ~/.terminfo $tempfile
    rm $tempfile
    echo "[config.fish] DONE Installing wezterm terminfo file"
else
    echo "[config.fish] SKIP Installing wezterm terminfo file"
end

# Install fisher if not already installed
if not type --quiet fisher
    echo "[config.fish] START Installing fisher"
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    echo "[config.fish] DONE Installing fisher"
else
    echo "[config.fish] SKIP Installing fisher"
end

echo "[config.fish] START fisher update"
fisher update
echo "[config.fish] DONE fisher update"

echo "[config.fish] START nvm install"
# It's hard to believe, but Amazon Linux 2 has libraries that are so old that NodeJS > 16 won't run
if test -e /etc/os-release && cat /etc/os-release | grep --quiet "Amazon Linux 2"
    nvm install v16
else
    nvm install latest
end
echo "[config.fish] DONE nvm install"

# If tmux is installed, install tpm and plugins
# This is sort of a port from the instructions here:
# 	https://github.com/tmux-plugins/tpm/blob/master/docs/automatic_tpm_installation.md
if type --quiet tmux
    if not test -d ~/.tmux/plugins/tpm
        echo "[config.fish] START Installing tpm"
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        echo "[config.fish] DONE Installing tpm"
    end

    echo "[config.fish] START Updating tpm plugins"
    ~/.tmux/plugins/tpm/bin/install_plugins
    echo "[config.fish] DONE Updating tpm plugins"
end

# Clean up
# Note: We do this before the next block which I sometimes update to run exec
set --erase ALREADY_PROCESSING_FISH_CONFIG 1

# If we're ssh'ed into a machine, and that machine has tmux, and we're not already running TMUX,
# then we almost definitely want to run it
if set --query SSH_TTY; and type --quiet tmux; and not set --query TMUX
    # Give myself a chance to read any interesting text from above
    if not read --nchars 1 --prompt-str \n"[config.fish] About to exec tmux. Press any key to continue"
        return
    end

    if not tmux has-session
        exec tmux new-session
    end

    exec tmux attach
end
