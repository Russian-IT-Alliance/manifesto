#!/usr/bin/env bash

signatureFile=${1}
gitCommitHash=$(PAGER= git log -n1 --format='%h' ${signatureFile})

curl -s api.github.com/repos/Russian-IT-Alliance/manifesto/commits/${gitCommitHash} | jq -r '.author.email'
