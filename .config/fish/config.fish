# Install wezterm terminfo if not already installed
if not toe -a | grep wezterm &> /dev/null
	set --export INSTALLING_WEZTERM_TERMINFO 1
	set --local tempfile $(mktemp)
	echo "START Installing wezterm terminfo file"
	curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo
	tic -x -o ~/.terminfo $tempfile
	rm $tempfile
	echo "DONE Installing wezterm terminfo file"
end

# Now that we have terminfo installed, make sure that fish knows we have 24-bit color support
set fish_term24bit 1

# Install fisher if not already installed
if not set --query INSTALLING_FISHER && not type --quiet "fisher"
	set --export INSTALLING_FISHER 1
	echo "START Installing fisher"
	curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
	echo "DONE Installing fisher"
end

# Install / update any fisher plugins
fisher update

# Use this area for machine-agnostic configuration (checked in to main branch of dotfiles repo)
set -g fish_key_bindings fish_vi_key_bindings

# Use this area for machine-specific configuration (checked in to dotfiles repo in separate branches)
