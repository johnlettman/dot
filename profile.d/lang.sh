#!/bin/sh
if [ -z "${LANG}" ]; then
    export LANG="en_US.UTF-8"
fi

export LC_ALL="${LANG}"
export LC_CTYPE="${LANG}"
