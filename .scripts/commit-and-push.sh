#!/usr/bin/env bash


setupGit() {
    git config --global user.email "bot@github.com"
    git config --global user.name "GitHub Bot"
}

gitCommit() {
    rm -f .failed-invites
    git add signatures verified-signatures
    git commit --message "Added verified signatures"
}

gitPush() {
    git checkout -b master
    git remote remove origin
    git remote add origin https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
    git push origin HEAD
}

setupGit && gitCommit && gitPush
