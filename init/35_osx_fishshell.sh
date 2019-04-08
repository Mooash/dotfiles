#!/usr/bin/env bash
# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P fish)" ]] && e_error "Fish shell needs to be installed." && return 1

if ! grep -q "$(type -P fish)" /etc/shells
then
	e_arrow "Adding Fish to '/etc/shells'"
	sudo cat $(type -P fish) >> /etc/shells
fi
e_arrow "Fish already in shells"
