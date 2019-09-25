#!/usr/bin/env bash

newSignature=${1}

email=$(./.scripts/get-author-email.sh ${newSignature})

{ ./.scripts/verify-signature.sh ${email} ${newSignature} && ./.scripts/send-invite.sh ${email} ${newSignature}; } || { echo ${newSignature} > .failed-invites; }
