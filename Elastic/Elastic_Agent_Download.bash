#!/bin/bash

######################################
# By: Oscar Reyes
# Last Update: July 4, 2024
# This script is meant help download the different parts of Elastic. The download varies depending on your
# enrollment token and URL.
######################################


#############################
# Depending on your enrollment token and URL, the installation will download different things.
# Your Elastic security administrator will have to give you both.
# 
# Variable you can change:
#############################
ENROLLMENT_TOKEN=""

ENROLLMENT_URL=""

AGENT_VERSION=""


#############################
# Start of script
#############################

# Check if the device is an Apple Silicon or Intel Device.
# The install command is different based on the chip architecture
processor=$(uname -m)

if [[ "$processor" == "arm64" ]]; then
    cd /tmp
    curl -L -O "https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-$AGENT_VERSION-darwin-aarch64.tar.gz"
    tar xzvf "elastic-agent-$AGENT_VERSION-darwin-aarch64.tar.gz"
    cd "elastic-agent-$AGENT_VERSION-darwin-aarch64"
    ./elastic-agent install --force --url="$ENROLLMENT_URL" --enrollment-token="$ENROLLMENT_TOKEN"


    cd /tmp
    rm -rf "/tmp/elastic-agent-$AGENT_VERSION-darwin-aarch64.tar.gz"
    rm -rf "/tmp/elastic-agent-$AGENT_VERSION-darwin-aarch64"

else
    cd /tmp
    curl -L -O "https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-$AGENT_VERSION-darwin-x86_64.tar.gz"
    tar xzvf "elastic-agent-$AGENT_VERSION-darwin-x86_64.tar.gz"
    cd "elastic-agent-$AGENT_VERSION-darwin-x86_64"
    ./elastic-agent install --force --url="$ENROLLMENT_URL" --enrollment-token="$ENROLLMENT_TOKEN"


    cd /tmp
    rm -rf "/tmp/elastic-agent-$AGENT_VERSION-darwin-x86_64.tar.gz"
    rm -rf "/tmp/elastic-agent-$AGENT_VERSION-darwin-x86_64"
fi

