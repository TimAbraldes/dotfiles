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
fisher update | tail --lines 1
echo "[config.fish] DONE fisher update"

echo "[config.fish] START nvm install"
# It's hard to believe, but Amazon Linux 2 has libraries that are so old that NodeJS > 16 won't run
if test -e /etc/os-release && cat /etc/os-release | grep --quiet "Amazon Linux 2"
    nvm install v16
else
    nvm install latest
end
echo "[config.fish] DONE nvm install"

# Clean up
# Note: We do this before the next block which I sometimes update to run exec
set --erase ALREADY_PROCESSING_FISH_CONFIG 1
