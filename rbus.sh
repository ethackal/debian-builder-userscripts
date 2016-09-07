#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt-get update -y && apt-get upgrade -y
apt-get install -y curl

mkdir /tmp/userscripts

role=$(curl http://169.254.169.254/latest/meta-data/iam/security-credentials/)
aws s3 sync s3://role-based-userscripts/$role /tmp/userscripts
chmod -R +x /tmp/userscripts/*

for userscript in /tmp/userscripts/*; do $userscript; done

