#!/bin/sh
export REPOS="${HOME}/repos"
[ -d "${REPOS}" ] || mkdir -p "${REPOS}"
alias torepos='cd ${REPOS}'

export GISTS="${REPOS}/_gists"
[ -d "GISTS" ] || mkdir -p "${GISTS}"
alias togists='cd ${GISTS}'

