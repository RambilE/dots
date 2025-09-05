#!/usr/bin/env bash
if [[ $(pgrep -lfx "footclient wiremix") == "" ]]; then
        footclient -T wiremix wiremix
        exit
fi
