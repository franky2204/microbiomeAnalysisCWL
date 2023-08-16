#!/bin/bash

string=$1
directory=$2
IFS=',' read -ra elements <<< "$string"

cp $directory/${elements[0]} .
cp $directory/${elements[1]} .
