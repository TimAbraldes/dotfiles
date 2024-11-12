function() {
  echo '[zshrc] START'

  local BREW_BIN_PATHS=('/home/linuxbrew/.linuxbrew/bin/brew' '/opt/Homebrew/bin/brew' '/usr/local/Homebrew/bin/brew')
  local BREW_BIN=''

  # Find brew
  for bin_path in $BREW_BIN_PATHS
  do
    if test -e $bin_path
    then
      BREW_BIN=$bin_path
      break
    fi
  done

  # Install brew if not found
  if [[ -z $BREW_BIN ]]
  then
    echo '[zshrc] START Installing brew'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Set BREW_BIN
    for bin_path in $BREW_BIN_PATHS
    do
	    if test -e $bin_path
	    then
		    BREW_BIN=$bin_path
		    break
	    fi
    done

    echo '[zshrc] DONE Installing brew'
  else
    echo '[zshrc] SKIP Installing brew'
  fi

  echo '[zshrc] START brew shellenv'
  if test -e $BREW_BIN
  then
    eval $($BREW_BIN shellenv)
  fi
  echo '[zshrc] DONE brew shellenv'


  if ! command -v brew > /dev/null 2>&1
  then
    echo '[zshrc] WARN brew not found'
  else
    echo '[zshrc] START Installing/upgrading brew packages'
    brew update

    local BREW_INSTALL_PKGS=(fish git neovim tmux)
    if [[ $(uname) = 'Darwin' ]]
    then
      BREW_INSTALL_PKGS+=(wezterm rectangle)
    fi
    brew install ${BREW_INSTALL_PKGS}


    brew upgrade
    echo '[zshrc] DONE Installing/upgrading brew packages'
  fi

  # Run fish
  if command -v fish > /dev/null 2>&1
  then
    # Give myself a chance to read any interesting text from above
    read -s -k $'?\n[zshrc] About to exec fish. Press any key to continue.\n'

    # Examples of why we need this:
    #   - `brew shellenv` needs to output fish-flavored shell script instead of zsh-flavored
    #   - tmux needs to start fish instead of zsh
    export SHELL=$(command -v fish)

    exec fish
  else
    echo '[zshrc] FAIL fish not found'
  fi
}
