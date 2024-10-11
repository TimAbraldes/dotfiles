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

# I've come to realize that I actually want brew on all the systems I currently maintain
# Maybe someday that won't be true but, at least on Amazon Linux 2, WSL2, and MacOS it's
# a reliable and frictionless way to get updated binaries
set --local BREW_BIN_MAC /usr/local/Homebrew/bin/brew
set --local BREW_BIN_LINUX /home/linuxbrew/.linuxbrew/bin/brew

if not test -e $BREW_BIN_MAC; and not test -e $BREW_BIN_LINUX
    echo "START Installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "DONE Installing brew"
else
    echo "SKIP Installing brew"
end

echo "START brew postinstall"
if test -e $BREW_BIN_MAC
    $BREW_BIN_MAC shellenv | source
    echo "DONE brew postinstall"
else if test -e $BREW_BIN_LINUX
    $BREW_BIN_LINUX shellenv | source
    echo "DONE brew postinstall"
else
    echo "WARN not able to perform brew postinstall"
end

function _ensure_brew_pkgs
    for PKG in $argv
        if ! brew list $PKG >/dev/null
            brew install $PKG
        end
    end
end

# If brew is installed on this system:
# 	- Update and upgrade
# 	- Install the necessities
if type --quiet brew
    echo "START brew update && brew upgrade"

    brew update

    _ensure_brew_pkgs fish git neovim

    # If we're in an ssh session, we want tmux
    if set --query SSH_TTY
        _ensure_brew_pkgs tmux
    end

    brew upgrade

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
