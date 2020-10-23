#!/bin/bash
set -e
for I in $(cat scripts/workspaces.ls)
do
  cd workspaces/$I
  git reset master
  git checkout -- .
  git pull >/dev/null
  git diff `git tag | tail -1` > ../../$I.diff
  if [ -s ../../$I.diff ]
  then
    echo update $I
  fi
  cd ../..
done