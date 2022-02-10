#!/bin/sh

# Usage: All arguments passed to the script will be interpreted as the commit message

cd ~/Documents/code/hugo/personal
rm -r public && hugo
git add -A
git commit -m "@$"
git subtree push --prefix public origin master
git push github master
