# Some commands that we'll run (e.g. fisher) will invoke fish, causing this file to be processed recursively
# Guard against that situation with an environment variable
if set --query ALREADY_PROCESSING_FISH_CONFIG
	exit
end

set --export ALREADY_PROCESSING_FISH_CONFIG 1

# Install wezterm terminfo if not already installed
if not toe -a | grep wezterm &> /dev/null
	echo "START Installing wezterm terminfo file"
	set --local tempfile $(mktemp)
	curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo
	tic -x -o ~/.terminfo $tempfile
	rm $tempfile
	echo "DONE Installing wezterm terminfo file"
else
	echo "SKIP Installing wezterm terminfo file"
end

# Now that we have terminfo installed, make sure that fish knows we have 24-bit color support
set fish_term24bit 1

# Install fisher if not already installed
if not type --quiet "fisher"
	echo "START Installing fisher"
	curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
	echo "DONE Installing fisher"
else
	echo "SKIP Installing fisher"
end

# Install / update any fisher plugins, but not if we're starting up inside TMUX
if not set --query TMUX; and not set --query FISHER_UPDATE
	echo "START fisher update"
	fisher update
	echo "DONE fisher update"
end

# Use this area for machine-agnostic configuration (checked in to main branch of dotfiles repo)
set -g fish_key_bindings fish_vi_key_bindings

# Use this area for machine-specific configuration (checked in to dotfiles repo in separate branches)
nvm install latest

set --erase ALREADY_PROCESSING_FISH_CONFIG 1
