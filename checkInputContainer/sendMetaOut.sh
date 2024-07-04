#!/bin/bash
filename=$(basename "$1")
complete="$2/$filename"
cp "$complete" .