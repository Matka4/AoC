#!/bin/bash

for NUM in {1..25}; do
    mkdir -p "day${NUM}"

    echo "# Day ${NUM}" >"day${NUM}/README.md"

    echo "- [ ] [Day ${NUM}](day${NUM})" >>README.md
done