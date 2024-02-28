#!/bin/bash
filename= $(basename "$1") 
slash="/"
complete= "$2$slash$filename"
cp $complete . 