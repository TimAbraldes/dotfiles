function() {
  local BREW_BIN_MAC=/usr/local/Homebrew/bin/brew
  local BREW_BIN_LINUX=/home/linuxbrew/.linuxbrew/bin/brew 

  # Install brew if not already installed
  if ! test -e $BREW_BIN_LINUX && ! test -e $BREW_BIN_MAC
  then
    echo START Installing brew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo DONE Installing brew
  else
    echo SKIP Installing brew
  fi

  # Put brew in PATH (linux version)
  if test -e $BREW_BIN_LINUX
  then
    echo START brew postinstall
    eval $($BREW_BIN_LINUX shellenv)
    echo DONE brew postinstall
  # Put brew in PATH (MacOS version)
  elif test -e $BREW_BIN_MAC
  then
    echo START brew postinstall
    eval $($BREW_BIN_MAC shellenv)
    echo DONE brew postinstall
  fi

  if ! command -v brew > /dev/null 2>&1
  then
    echo WARN brew not found, will not try to install fish
  else
    if ! brew list fish > /dev/null 2>&1
    then
      echo START Installing fish
      brew install fish
      echo DONE Installing fish
    else
      echo SKIP Installing fish
    fi
  fi

  if command -v fish > /dev/null 2>&1
  then
    export SHELL=$(command -v fish)
    exec fish
  else
    echo FAIL fish not found
  fi
}
