# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew recipes need Homebrew to install." && return 1

# Homebrew recipes
recipes=(
  ansible
  arping
  autojump
  automake
  autossh
  awscli
  bash
  bash-completion
  bash-git-prompt
  brotli
  clamav
  cmake
  coreutils
  cpanminus
  curl
  dbus
  dhcping
  dirmngr
  dos2unix
  ffmpeg
  fish
  fortune
  gawk
  ghi
  git
  git-extras
  git-lfs
  glide
  gnu-sed
  gnupg
  go
  gpg-agent
  guetzli
  heroku/brew/heroku
  htop
  httpdiff
  httpie
  httrack
  hugo
  imagemagick
  imapfilter
  ipcalc
  iperf
  isl@0.11
  jq
  libusb-compat
  livestreamer
  lynx
  linode/cli/linode-cli
  lolcat
  macvim
  md5sha1sum
  minicom
  mosh
  mtr
  mutt
  nmap
  node
  nvm
  offlineimap
  homebrew/nginx/openresty
  homebrew/nginx/openresty-debug
  homebrew/nginx/openresty-openssl
  platypus
  p7zip
  pkg-config
  pipenv
  pwgen
  pyenv-virtualenv
  qt
  redis
  rtv
  rpm2cpio
  rsync
  ruby
  shellcheck
  s3cmd
  ssh-copy-id
  sslscan
  streamlink
  subversion
  tiger-vnc
  terminal-notifier
  tmux
  tor
  unrar
  watch
  weechat
  wego
  wget
  wireshark
)

brew_install_recipes

# Misc cleanup!

# This is where brew stores its binary symlinks
local binroot="$(brew --config | awk '/HOMEBREW_PREFIX/ {print $2}')"/bin

# htop
if [[ "$(type -P $binroot/htop)" ]] && [[ "$(stat -L -f "%Su:%Sg" "$binroot/htop")" != "root:wheel" || ! "$(($(stat -L -f "%DMp" "$binroot/htop") & 4))" ]]; then
  e_header "Updating htop permissions"
  sudo chown root:wheel "$binroot/htop"
  sudo chmod u+s "$binroot/htop"
fi

# bash
if [[ "$(type -P $binroot/bash)" && "$(cat /etc/shells | grep -q "$binroot/bash")" ]]; then
  e_header "Adding $binroot/bash to the list of acceptable shells"
  echo "$binroot/bash" | sudo tee -a /etc/shells >/dev/null
fi
if [[ "$(dscl . -read ~ UserShell | awk '{print $2}')" != "$binroot/bash" ]]; then
  e_header "Making $binroot/bash your default shell"
  sudo chsh -s "$binroot/bash" "$USER" >/dev/null 2>&1
  e_arrow "Please exit and restart all your shells."
fi
