#!/bin/bash

function updatePanesRepo {
  cd $1
  git checkout master
  git pull
  npm install solid-ui@latest
  git commit -am'npm install solid-ui@latest'
  npm version minor
  npm publish -timeout=9999999
  cd ..
}

function updateAll {
  updatePanesRepo 
}