# Install brew if not already installed
if ! test -e /home/linuxbrew/.linuxbrew/bin/brew && ! test -e /usr/local/Homebrew/bin/brew
then
  echo START Installing brew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo DONE Installing brew
else
  echo SKIP Installing brew
fi

# Put brew in PATH (linux version)
if test -e /home/linuxbrew/.linuxbrew/bin/brew
then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

# Put brew in PATH (MacOS version)
if test -e /usr/local/Homebrew/bin/brew
then
  eval $(/usr/local/Homebrew/bin/brew shellenv)
fi

if ! command -v brew
then
  echo WARN brew not found, will not try to install fish
else
  if ! brew list fish > /dev/null 2>&1
  then
    echo START Installing fish
    brew install fish
    echo DONE Installing fish
  fi
fi

# In cases where zsh is the default shell and I can't (or can't be bothered to)
# change it, make zsh exec fish
if command -v fish
then
  export SHELL=$(command -v fish)
	exec fish
else
  echo FAIL fish not found
fi
