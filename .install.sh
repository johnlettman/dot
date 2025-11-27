#!/usr/bin/env bash
set -e
source "$(dirname "${BASH_SOURCE[0]}")/.scripts/utils.sh"

config="${repo_dir}/.install.yaml"
dotbot_dir="${repo_dir}/.dotbot"
dotbot_plugins_dir="${repo_dir}/.plugins"
dotbot_bin="${dotbot_dir}/bin/dotbot"

dotbot_plugins=(
	"if/if.py"
	"sync/sync.py"
	"sudo/sudo.py"
	"git/git.py"
    "../../repos/dotbot-paru/paru.py"
	"pacman/pacman.py"
	"ifhostname/ifhostname.py"
)

git -C "${dotbot_dir}" submodule sync --quiet --recursive
git submodule update --init --recursive "${dotbot_dir}"

# shellcheck disable=SC2068,SC2046
"${dotbot_bin}" -vv \
    $(join "-p ${dotbot_plugins_dir}/" ${dotbot_plugins[@]}) \
    -d "${repo_dir}" \
    -c "${config}" \
    "${@}"
