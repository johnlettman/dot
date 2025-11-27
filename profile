#!/bin/sh
export DOT="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"

has_program() {
	hash "$@" >/dev/null 2>&1
}

in_path() {
	echo "${PATH}" | tr ':' '\n' | grep -qx "$1"
}

prepend_path() {
	for dir in "$@"; do
		if [ -d "${dir}" ] && ! in_path "${dir}"; then
			if [ -z "${PATH}" ]; then
				PATH="${dir}"
			else PATH="${dir}:${PATH}"; fi
		fi
	done
}

append_path() {
	for dir in "$@"; do
		if [ -d "${dir}" ] && ! in_path "${dir}"; then
			if [ -z "${PATH}" ]; then
				PATH="${dir}"
			else PATH="${PATH}:${dir}"; fi
		fi
	done
}

in_manpath() {
	echo "${MANPATH}" | tr ':' '\n' | grep -qx "$1"
}

prepend_manpath() {
	for dir in "$@"; do
		if [ -d "${dir}" ] && ! in_path "${dir}"; then
			if [ -z "${MANPATH}" ]; then
				MANPATH="${dir}"
			else MANPATH="${dir}:${MANPATH}"; fi
		fi
	done
}

append_manpath() {
	for dir in "$@"; do
		if [ -d "${dir}" ] && ! in_path "${dir}"; then
			if [ -z "${MANPATH}" ]; then
				MANPATH="${dir}"
			else MANPATH="${MANPATH}:${dir}"; fi
		fi
	done
}

[ -d "${HOME}/.local/bin" ] && prepend_path "${HOME}/.local/bin"
[ -d "${HOME}/.bin" ] && prepend_path "${HOME}/.bin"
[ -d "${HOME}/bin" ] && prepend_path "${HOME}/bin"

[ -d "${HOME}/.profile.d" ] && {
    for f in "${HOME}/.profile.d"/*.sh; do
        # shellcheck source=/dev/null
        . "${f}"
    done
}





