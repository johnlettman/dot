#!/usr/bin/env bash
set -e;
set -u;
set -o pipefail;

scripts_dir="$(dirname "$(realpath "${BASH_SOURCE[0]:-$0}")")";

# shellcheck source=SCRIPTDIR/bashlog/log.sh
source "${scripts_dir}/bashlog/log.sh";

prev_dir="$(pwd)";
repo_dir="${scripts_dir}/../";

pushd . >'/dev/null' || \
    log debug "Unable to push previous directory. No problem.";

# while the path refers to a symbolic link,
# read the link until we achieve the real path
while [ -h "${repo_dir}" ]; do 
    cd "$(dirname -- "${repo_dir}")" || {
        log error "Unable to change directories; something is wrong!";
        exit 1;
    };

    repo_dir="$(readlink -f -- "${repo_dir}")";
done;

cd "${repo_dir}" || {
    log error "Unable to change directories; something is wrong!";
    exit 1;
};

repo_dir="$(pwd)";

# return to the previous directory prior to these operations
popd >'/dev/null' || cd "${prev_dir}" || {
    log error \
        "Unable to return to prior directory!" \
        "Prior directory: ${prev_dir}";
};

unset prev_dir;
export repo_dir;


join() {
    local prefix="$1";
    shift;
    local arr=("$@");

    for i in "${!arr[@]}"; do
        arr[i]="${prefix}${arr[i]}";
    done;

    echo "${arr[*]}";
}