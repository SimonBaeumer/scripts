#!/usr/bin/env bash
set -euo pipefail
# Remove local branches which do not exist on remote

remote_dest=${1-origin}
echo "Remote: ${remote_dest}"

for i in $(git for-each-ref --format='%(refname)' refs/heads/); do
    local_branch=$(echo "$i" | awk -F '/' '{print $3}')
    echo "Checking branch ${local_branch}"

    remote_branch=$(git ls-remote --heads "${remote_dest}" "${local_branch}")
    if [[ -z "${remote_branch}" ]]; then
        echo "Remove $local_branch..."
        git branch -D "${local_branch}"
    else
        echo "Found $local_branch, do not remove"
    fi
done

