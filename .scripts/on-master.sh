#!/usr/bin/env bash

export FORK_LIMIT=10

bin=$(readlink -f $(dirname $0))

mkdir -p verified-signatures

touch .failed-invites
find signatures -type f -not \( -name .gitkeep \) -exec echo ${bin}/verify-and-invite.sh '{}' \; | grep -v | ${bin}/lib/concurrently.sh

[[ "$(cat .failed-invites | wc -l)" != '0' ]] && exit -1
${bin}/commit-and-push.sh
