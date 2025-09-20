#!/usr/bin/env bash
if [[ $(pgrep -fx "footclient -T wiremix wiremix") == "" ]]; then
        footclient -T wiremix wiremix
        exit
fi
