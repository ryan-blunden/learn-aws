#! /usr/bin/env bash

# ---------------------------------------------------------------------
# [Author] Ryan Blunden and Aaron Addleman
#          Convenience script for AWS CLI authentication requriing MFA
# ---------------------------------------------------------------------

VERSION=0.1.0
UPDATED=2017-11-07
USAGE="Usage: . ./bin/$(basename "$0") -a <account-number> -u <username> -t <mfa-token>"
OPTIND=1

if [ $# == 0 ]; then
    echo $USAGE

    if [ $SHLVL == 2 ]; then
        exit
    else
        return
    fi
fi

while getopts a:u:t: option
do
 case "${option}"
 in
 a) ACCOUNT_NUMBER=${OPTARG};;
 u) IAM_USERNAME=${OPTARG};;
 t) TOKEN_CODE=${OPTARG};;
 esac
done

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
unset AWS_SESSION_EXPIRE

aws configure

results=$(aws sts get-session-token --serial-number arn:aws:iam::${ACCOUNT_NUMBER}:mfa/${IAM_USERNAME} --token-code ${TOKEN_CODE})

if [ $? -gt 0 ]; then
    return
fi

export AWS_ACCESS_KEY_ID=$(echo $results | jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(echo $results | jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(echo $results | jq -r '.Credentials.SessionToken')
export AWS_SESSION_EXPIRE=$(echo $results | jq -r '.Credentials.Expiration')

echo "[info]: Successfully authenticated"
