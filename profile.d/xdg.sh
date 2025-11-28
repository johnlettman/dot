#!/bin/sh
# Set XDG base dirs
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"

# Ensure XDG dirs exist
for dir in \
	"${XDG_CONFIG_HOME}" "${XDG_CACHE_HOME}" \
	"${XDG_DATA_HOME}" "${XDG_STATE_HOME}"
do
	[ -d "${dir}" ] || mkdir -p "${dir}"
done

# Fix missing snap application icons in KDE
export XDG_DATA_DIRS="${XDG_DATA_DIRS}:/var/lib/snapd/desktop"
