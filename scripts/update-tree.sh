#!/bin/bash
set -e

function updateRepo {
  echo $1 $2 $3
}

updateRepo acl-check "@solid/acl-check" node-solid-server
updateRepo chat-pane "chat-pane" solid-panes
updateRepo contacts-pane "contacts-pane" solid-panes
updateRepo issue-pane "issue-pane" solid-panes
updateRepo folder-pane "folder-pane" solid-panes
updateRepo jose "@solid/jose" oidc-rp
updateRepo keychain "@solid/keychain"
updateRepo mashlib "mashlib" node-solid-server
updateRepo meeting-pane "meeting-pane" solid-panes
updateRepo node-solid-ws "solid-ws" node-solid-server
updateRepo oidc-auth-manager "@solid/oidc-auth-manager" node-solid-server
updateRepo oidc-op "@solid/oidc-op" node-solid-server oidc-auth-manager
updateRepo oidc-rp "@solid/oidc-rp" solid-cli solid-auth-oidc oidc-auth-manager solid-multi-rp-client solid-auth-client
updateRepo pane-registry "pane-registry" solid-panes issue-pane solid-ui
updateRepo rdflib "rdflib" node-solid-server acl-check mashlib solid-panes issue-pane solid-ui pane-registry
updateRepo solid-auth-client "solid-auth-client" node-solid-server solid-ui
updateRepo solid-auth-oidc "solid-auth-oidc" node-solid-server
# updateRepo solid-cli "solid-cli" solid-auth-cli
updateRepo solid-multi-rp-client "solid-multi-rp-client" oidc-auth-manager
updateRepo solid-namespace "solid-namespace" node-solid-server acl-check solid-ui
updateRepo solid-panes "solid-panes" mashlib
# updateRepo solid-rest "solid-rest" solid-auth-cli
updateRepo solid-ui "solid-ui" mashlib solid-panes
updateRepo source-pane "source-pane" solid-panes
