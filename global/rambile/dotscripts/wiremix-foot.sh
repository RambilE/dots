#!/usr/bin/env bash
if [[ $(pgrep -lfx "footclient -T wiremix wiremix") == "" ]]; then
        footclient -T wiremix wiremix
        exit
fi
