#!/bin/sh
#
# Project paths
#
[ -z "${REPOS}" ] && export REPOS="${HOME}/repos"
[ -d "${REPOS}" ] || mkdir -p "${REPOS}"
alias torepos='cd ${REPOS}'

[ -z "${GISTS}" ] && export GISTS="${REPOS}/_gists"
[ -d "GISTS" ] || mkdir -p "${GISTS}"
alias togists='cd ${GISTS}'

#
# pyenv: Python environment
#
[ -z "${PYENV_HOME}" ] && export PYENV_HOME="${HOME}/.local/pyenv"
[ -d "${PYENV_HOME}" ] || mkdir -p "${PYENV_HOME}"

#
# npm: Node packages
#
[ -z "${NPM_PACKAGES}" ] && export NPM_PACKAGES="${HOME}/.local/npm-packages"
[ -d "${NPM_PACKAGES}" ] || mkdir -p "${NPM_PACKAGES}"

append_path "${NPM_PACKAGES}/bin"
append_manpath "${NPM_PACKAGES}/share/man"

#
# nvm: Node Version Manager
#
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

[ -z "${NVM_DIR}" ] && export NVM_DIR="${HOME}/.local/nvm"
[ -d "${NVM_DIR}" ] || mkdir -p "${NVM_DIR}"

if [ -n "${BASH}" ] && [ -s "${NVM_DIR}/bash_completion" ]; then
	# shellcheck disable=SC1091
	. "${NVM_DIR}/bash_completion"
fi

#
# Golang
#
if has_program go; then
	[ -z "${GOPATH}" ] && export GOPATH="${REPOS}/_go"
	[ -d "${GOPATH}" ] || mkdir -p "${GOPATH}"

	append_path "${GOPATH}/bin"
fi
