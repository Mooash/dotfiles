# Only run on OSX Machines
is_osx || return 1

# Set our gopath
export GOPATH="$HOME/gocode"
PATH="$PATH:$HOME/gocode/bin"
export PATH
