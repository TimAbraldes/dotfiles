set fish_term24bit 1

set -g fish_key_bindings fish_vi_key_bindings

if not set --query INSTALLING_FISHER && not type --quiet "fisher"
	set -x INSTALLING_FISHER 1
	curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update
end
