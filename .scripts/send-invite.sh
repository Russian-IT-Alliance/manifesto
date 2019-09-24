#!/usr/bin/env bash

email=${1}

curl https://slack.com/api/users.admin.invite?token=${SLACK_TOKEN}&email=${email}&resend=false &>/dev/null
