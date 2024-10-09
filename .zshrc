# Use this area for machine-specific configuration (in branches)


# On Mac, fish should be installed via Homebrew
if [[ $(uname) == "Darwin" ]] && ! command -v fish
then
	if ! command -v brew
	then
		echo START Installing Homebrew
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		echo DONE Installing Homebrew
	else
		echo SKIP Installing Homebrew
	fi

	echo START Installing fish
	brew install fish
	echo DONE Installing fish
fi

# In cases where zsh is the default shell and I can't (or can't be bothered to)
# change it, make zsh exec fish
if command -v fish
then
	exec fish
fi
