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
    echo "START Installing wezterm terminfo file"
    set --local tempfile $(mktemp)
    curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo
    tic -x -o ~/.terminfo $tempfile
    rm $tempfile
    echo "DONE Installing wezterm terminfo file"
else
    echo "SKIP Installing wezterm terminfo file"
end

# Getting updated binaries onto Amazon Linux 2 is kind of a nightmare
# so we'll use brew for this purpose
if cat /etc/os-release | grep --quiet "Amazon Linux 2"
    echo "START Installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "DONE Installing brew"
else
    echo "SKIP Installing brew"
end

# If brew is installed on this system:
# 	- Update and upgrade
# 	- Install the necessities
if type --quiet brew
    echo "START brew update && brew upgrade"

    brew update && brew upgrade

    # Install neovim if not already installed
    if not type --quiet nvim
        brew install neovim
    end

    # Install git if not already installed
    if not type --quiet git
        brew install git
    end

    echo "DONE brew update && brew upgrade"
end

# Install fisher if not already installed
if not type --quiet fisher
    echo "START Installing fisher"
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    echo "DONE Installing fisher"
else
    echo "SKIP Installing fisher"
end

# Install / update any fisher plugins
fisher update

# It's hard to believe, but Amazon Linux 2 has libraries that are so old that NodeJS > 16 won't run
if cat /etc/os-release | grep --quiet "Amazon Linux 2"
    nvm install v16
else
    nvm install latest
end

# If tmux is installed, install tpm and plugins
# This is sort of a port from the instructions here:
# 	https://github.com/tmux-plugins/tpm/blob/master/docs/automatic_tpm_installation.md
if type --query tmux
    if not test -d ~/.tmux/plugins/tpm
        echo START Installing tpm
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        echo DONE Installing tpm
    end

    echo START Updating tpm plugins
    ~/.tmux/plugins/tpm/bin/install_plugins
    echo DONE Updating tpm plugins
end

# Clean up
# Note: We do this before the next block which potentially calls exec
set --erase ALREADY_PROCESSING_FISH_CONFIG 1

# If we're ssh'ed into a machine, and that machine has tmux, we almost definitely want to run it
if set --query SSH_TTY; and type --query tmux
    if not tmux has-session -t default-session
        exec tmux new-session -s default-session
    end
    exec tmux attach -t default-session
end
