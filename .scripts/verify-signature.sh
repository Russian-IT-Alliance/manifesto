#!/usr/bin/env bash

emailInCommit=${1}
signatureFile=${2}

keyId=$(gpg --status-fd 1 --verify ${signatureFile} README.md 2>/dev/null | grep '\[GNUPG\:\] VALIDSIG' | cut -d' ' -f3)

[[ $(find verified-signatures -type f -name *.${keyId}.sig | wc -l) == "0" ]] || { echo "You've already signed!" >&2; exit 3; }

[[ n"${keyId}" == "n" ]] && { echo "Invalid signature. Did you use detached signature?" >&2; exit 2; }

gpg --recv ${keyId} 2>/dev/null || { echo "No key found on trusted resource!" >&2; exit 1; }

mapfile -t emails < <(gpg --with-colons --list-key ${keyId} | grep '^uid' | cut -d':' -f 10 | grep -Po '<.*?>')

found=n
for (( i=0; i < ${#emails[@]}; i++ )); do
    if [[ "${emails[${i}]}" == "<${emailInCommit}>" ]]; then
        found=y
    fi
done

[[ "${found}" == 'n' ]] && { echo "Email in commit differs from email[s] in public key!" >&2; exit 1; }

signatureFileName=$(echo ${signatureFile} | tr '/' '\n' | tail -n1)
mv ${signatureFile} verified-signatures/${signatureFileName}.${keyId}.sig
