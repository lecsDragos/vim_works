#!/bin/sh

git pull origin master
git submodule init
git submodule update
git submodule foreach git submodule init
git submodule foreach git submodule update
git submodule foreach git pull origin master


# in case command-t does not work: https://github.com/wincent/command-t/issues/152
