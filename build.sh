#!/bin/sh

# Usage: All arguments passed to the script will be interpreted as the commit message

cd `pwd`
rm -r public 
hugo --minify && git add -A; git commit -m "$1"; git push github master
