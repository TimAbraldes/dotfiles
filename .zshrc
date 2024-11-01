function() {
  echo '[zshrc] START'

  local BREW_BIN_MAC=/usr/local/Homebrew/bin/brew
  local BREW_BIN_LINUX=/home/linuxbrew/.linuxbrew/bin/brew 

  # Install brew if not already installed
  if ! test -e $BREW_BIN_LINUX && ! test -e $BREW_BIN_MAC
  then
    echo '[zshrc] START Installing brew'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo '[zshrc] DONE Installing brew'
  else
    echo '[zshrc] SKIP Installing brew'
  fi

  echo '[zshrc] START brew shellenv'
  if test -e $BREW_BIN_LINUX
  then
    eval $($BREW_BIN_LINUX shellenv)
  elif test -e $BREW_BIN_MAC
  then
    eval $($BREW_BIN_MAC shellenv)
  fi
  echo '[zshrc] DONE brew shellenv'


  if ! command -v brew > /dev/null 2>&1
  then
    echo '[zshrc] WARN brew not found, will not try to install fish'
  else
    echo '[zshrc] START Installing/upgrading brew packages'
    brew install fish git neovim tmux
    echo '[zshrc] DONE Installing/upgrading brew packages'
  fi

  if command -v fish > /dev/null 2>&1
  then
    # This line is important because otherwise commands like `brew shellenv` will
    # spit out zsh-flavored script instead of fish-flavored script
    export SHELL=$(command -v fish)

    # Give myself a chance to read any interesting text from above
    read -s -k $'?\n[zshrc] About to exec fish. Press any key to continue.\n'
    exec fish
  else
    echo '[zshrc] FAIL fish not found'
  fi
}
