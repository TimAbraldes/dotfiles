# Use this area for machine-specific configuration (in branches)


# In cases where zsh is the default shell and I can't (or can't be bothered to)
# change it, make zsh exec fish
if command -v fish
then
	exec fish
fi
