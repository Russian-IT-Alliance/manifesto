#!/usr/bin/env bash

FORK_LIMIT=${FORK_LIMIT:-5}

while read nextJob; do
    if [[ $(jobs -pr | wc -l) -ge ${FORK_LIMIT} ]]; then
        echo "Hit fork limit"
        wait -n
        echo "Awaited one job, current jobs count: $(jobs -pr | wc -l)"
    else
        echo "Forking new job"
        ( eval ${nextJob} ) &
    fi
done

wait
