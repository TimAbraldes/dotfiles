if not toe -a | grep wezterm &> /dev/null
	set --export INSTALLING_WEZTERM_TERMINFO 1
	set --local tempfile $(mktemp)
	echo "START Installing wezterm terminfo file"
	curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo
	tic -x -o ~/.terminfo $tempfile
	rm $tempfile
	echo "DONE Installing wezterm terminfo file"
end

set fish_term24bit 1

set -g fish_key_bindings fish_vi_key_bindings

if not set --query INSTALLING_FISHER && not type --quiet "fisher"
	set -x INSTALLING_FISHER 1
	curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update
end
