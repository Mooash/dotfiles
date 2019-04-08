# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew recipes need Homebrew to install." && return 1

# Homebrew recipes
recipes=(
  ansible
  ansible-lint
  arping
  autoconf
  autojump
  automake
  autossh
  awscli
  bash
  bash-completion
  bash-git-prompt
  bat
  brotli
  clamav
  cmake
  colordiff
  coreutils
  curl
  dbus
  dhcping
  direnv
  dirmngr
  dnstrace
  docker
  docker-compose
  docker-machine
  dos2unix
  fabric
  ffmpeg
  fish
  fortune
  gawk
  gettext
  ghi
  git
  git-extras
  git-lfs
  glide
  gnu-sed
  gnupg
  gnutls
  go
  gpg-agent
  guetzli
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
  lolcat
  macvim
  md5sha1sum
  minicom
  mosh
  mtr
  mutt
  nativefier
  nettle
  nmap
  node
  nvm
  offlineimap
  p7zip
  pigz
  pipenv
  platypus
  postgresql
  pwgen
  pyenv
  pyenv-virtualenv
  python
  python3
  python@2
  qrencode
  qt
  rbenv
  rdesktop
  readline
  redis
  rpm2cpio
  rsync
  rtv
  ruby
  ruby-build
  s3cmd
  screenfetch
  screenresolution
  shellcheck
  speedtest-cli
  ssh-copy-id
  sslscan
  streamlink
  subnetcalc
  subversion
  terminal-notifier
  tiger-vnc
  tmux
  tor
  tree
  unbound
  unrar
  watch
  weechat
  wego
  wget
  wireshark
  xz
  yarn
  youtube-dl
  yq
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
