# Install wezterm terminfo if not already installed
if not toe -a | grep wezterm &> /dev/null
	echo "START Installing wezterm terminfo file"
	set --local tempfile $(mktemp)
	curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo
	tic -x -o ~/.terminfo $tempfile
	rm $tempfile
	echo "DONE Installing wezterm terminfo file"
end

# Now that we have terminfo installed, make sure that fish knows we have 24-bit color support
set fish_term24bit 1

# Install fisher if not already installed
if not set --query FISHER_INSTALL && not type --quiet "fisher"
	echo "START Installing fisher"
	set --export FISHER_INSTALL 1

	curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source

	echo "DONE Installing fisher"
	set --erase FISHER_INSTALL
end

# Install / update any fisher plugins
if not set --query FISHER_UPDATE
	echo "START fisher update"
	set --export FISHER_UPDATE 1

	fisher update

	set --erase FISHER_UPDATE
	echo "DONE fisher update"
end

# Use this area for machine-agnostic configuration (checked in to main branch of dotfiles repo)
set -g fish_key_bindings fish_vi_key_bindings

# Use this area for machine-specific configuration (checked in to dotfiles repo in separate branches)
