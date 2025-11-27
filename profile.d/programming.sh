#!/bin/sh
#
# pyenv: Python environment
#
[ -z "${PYENV_HOME}" ] && export PYENV_HOME="${HOME}/.local/pyenv"
[ -d "${PYENV_HOME}" ] || mkdir -p "${PYENV_HOME}"
