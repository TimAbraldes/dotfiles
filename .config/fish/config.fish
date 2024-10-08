# Put any configuration that should happen even in non-interactive usage here


# Most of this file shouldn't be run if we're just executing a fish script.
# Go ahead and exit at this point if we're not running interactively
if not status is-interactive
	exit
end

# Some commands that we'll run (e.g. fisher) will invoke fish, causing this file to be processed recursively
# Guard against that situation with an environment variable
if set --query ALREADY_PROCESSING_FISH_CONFIG
	exit
end

set --export ALREADY_PROCESSING_FISH_CONFIG 1

# Install wezterm terminfo if not already installed
if not toe -a | grep --quiet "wezterm"
	echo "START Installing wezterm terminfo file"
	set --local tempfile $(mktemp)
	curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo
	tic -x -o ~/.terminfo $tempfile
	rm $tempfile
	echo "DONE Installing wezterm terminfo file"
else
	echo "SKIP Installing wezterm terminfo file"
end

# Install fisher if not already installed
if not type --quiet "fisher"
	echo "START Installing fisher"
	curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
	echo "DONE Installing fisher"
else
	echo "SKIP Installing fisher"
end

# Install / update any fisher plugins, but not if we're starting up inside TMUX
if not set --query TMUX
	fisher update
end

# It's hard to believe, but Amazon Linux 2 has libraries that are so old that NodeJS > 16 won't run
if cat /etc/os-release | grep --quiet "Amazon Linux 2"
	nvm install v16
else
	nvm install latest
end

# Use this area for machine-agnostic configuration (checked in to main branch of dotfiles repo)
set -g fish_key_bindings fish_vi_key_bindings
set fish_term24bit 1

# Use this area for machine-specific configuration (checked in to dotfiles repo in separate branches)


# Clean up
set --erase ALREADY_PROCESSING_FISH_CONFIG 1

# If we're ssh'ed into a machine, and that machine has tmux, we almost definitely want to run it
if set --query SSH_TTY; and type --query tmux; and not set --query TMUX
	exec tmux new-session -A default-tmux-session
end
