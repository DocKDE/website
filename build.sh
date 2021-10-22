#!/bin/sh

# Usage: First command line argument will be git commit message

rm -r public && hugo
git add -A
git commit -m $1
# git subtree push --prefix public origin master
git push github master
