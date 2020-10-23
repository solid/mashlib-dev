#!/bin/bash
set -e


function updateSolidUI {
  cd solid-ui
  git checkout master
  git pull
  npm install solid-ui@latest chat-pane@latest contacts-pane@latest folder-pane@latest issue-pane@latest meeting-pane@latest source-pane@latest
  git commit -am'npm install solid-ui@latest chat-pane@latest contacts-pane@latest folder-pane@latest issue-pane@latest meeting-pane@latest source-pane@latest'
  npm version minor
  npm publish -timeout=9999999
  cd ..
}

function updateSolidPanes {
  updateSolidUI
  updatePaneRepo chat-pane
  updatePaneRepo contacts-pane
  updatePaneRepo folder-pane
  updatePaneRepo issue-pane
  updatePaneRepo meeting-pane
  updatePaneRepo source-pane
  cd solid-panes
  git checkout master
  git pull
  npm install solid-ui@latest chat-pane@latest contacts-pane@latest folder-pane@latest issue-pane@latest meeting-pane@latest source-pane@latest
  git commit -am'npm install solid-ui@latest chat-pane@latest contacts-pane@latest folder-pane@latest issue-pane@latest meeting-pane@latest source-pane@latest'
  npm version minor
  npm publish -timeout=9999999
  cd ..
}

function updateMashlib {
  updateSolidPanes
  cd mashlib
  git checkout master
  git pull
  npm install rdflib@latest solid-namespace@latest solid-ui@latest solid-panes@latest
  git commit -am'npm install rdflib@latest solid-namespace@latest solid-ui@latest solid-panes@latest'
  npm version minor
  npm publish -timeout=9999999
  cd ..
}

function updateNss {
  updateMashlib
  cd node-solid-server
  git checkout master
  git pull
  npm install rdflib@latest solid-namespace@latest solid-ui@latest solid-panes@latest
  git commit -am'npm install mashlib@latest'
  npm version minor
  npm publish -timeout=9999999
  cd ..
}

updateNss