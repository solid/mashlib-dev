#!/bin/bash
set -e

function updateRepo1 {
  if [ ! -d workspaces/$1 ]; then
    echo "Creating workspace $1"
    npm run add $1
  fi
  if [ ! -d workspaces/$1 ]; then
    echo "Workspace not found! $1" 1>&2
    exit 64
  fi
  echo Updating $1
  cd workspaces/$1
  sed -i -e 's/https...github.com./git@github.com:/g' .git/config
  git checkout master
  git pull
  rm -rf node_modules
  rm package-lock.json
  npx npm-check-updates -u
  npm install
}
function updateRepo2 {
  npm test
  npm run build
  ( git commit -am"Update dependencies" && npm version patch && npm publish -timeout=9999999 ) || echo No change in $1
  cd ../..
  echo Finished $1
  # updateRepo $3 ""
}
function updateRepo {
  echo Starting $1
  updateRepo1 $1
  updateRepo2 $1
}

updateRepo jose # @solid/jose (@sinonjs/text-encoding, base64url, isomorphic-webcrypto)
updateRepo oidc-rp # @solid/oidc-rp (@solid/jose, base64url, isomorphic-webcrypto, node-fetch, standard-http-error, whatwg-url)

updateRepo solid-auth-client # solid-auth-client (@babel/runtime, auth-header, commander, isomorphic-fetch, @solid/oidc-rp)
npm install --save-dev flow-bin@0.130
npm install --save-dev eslint-plugin-jest@23.19.0
npm install --save-dev webpack@4
npm install --save-dev webpack-cli@3
updateRepo2 solid-auth-client

updateRepo pane-registry # pane-registry (rdflib)
updateRepo rdflib # rdflib (jsonld, n3, xmldom)
updateRepo solid-namespace # solid-namespace
updateRepo1 solid-ui # solid-ui (pane-registry, rdflib, solid-auth-client, solid-namespace)
npm install --save-dev @typescript-eslint/eslint-plugin@3
npm install --save-dev @typescript-eslint/parser@3
updateRepo2 solid-ui

updateRepo activitystreams-pane
updateRepo chat-pane # chat-pane (solid-ui)
updateRepo contacts-pane # contacts-pane (solid-ui)
updateRepo folder-pane # folder-pane (solid-ui)
updateRepo issue-pane # issue-pane (solid-ui, pane-registry, rdflib)
updateRepo meeting-pane # meeting-pane (solid-ui)
updateRepo source-pane # source-pane (solid-ui)

updateRepo1 solid-panes # solid-panes (chat-pane, contacts-pane, folder-pane, issue-pane, meeting-pane, pane-registry, rdflib, solid-ui, source-pane)
npm install --save-dev @typescript-eslint/eslint-plugin@3
npm install --save-dev @typescript-eslint/parser@3
updateRepo2 solid-panes

updateRepo1 mashlib # mashlib (rdflib, solid-panes, solid-ui)
npm install --save-dev @typescript-eslint/eslint-plugin@3
npm install --save-dev @typescript-eslint/parser@3
npm install --save-dev webpack@4
npm install --save-dev webpack-cli@3
updateRepo2 mashlib

updateRepo node-solid-ws # node-solid-ws ()
updateRepo acl-check # @solid/acl-check (rdflib, solid-namespace)
updateRepo keychain # @solid/keychain
updateRepo oidc-op # @solid/oidc-op (@solid/keychain)
updateRepo solid-multi-rp-client # solid-multi-rp-client (oidc-rp)
updateRepo oidc-auth-manager # oidc-auth-manager (oidc-rp, oidc-op, solid-multi-rp-client)
updateRepo solid-auth-oidc @solid/solid-auth-oidc (@solid/oidc-rp)
updateRepo node-solid-server (@solid/acl-check, @solid/oidc-auth-manager, rdflib, mashlib, solid-auth-client, solid-namespace, solid-ws, @solid/oidc-op, @solid/solid-auth-oidc)

updateRepo solid-rest # solid-rest (concat-stream, cross-fetch, fs-extra, mime-types)
updateRepo solid-cli # solid-cli (@solid/oidc-rp)
updateRepo solid-auth-cli # solid-auth-cli (@solid/cli, async, cross-fetch, jsonld, n3, solid-rest)

updateRepo solid-auth-fetcher
updateRepo webid-provider-tests
updateRepo solid-crud-tests
updateRepo gitter-solid
updateRepo github-solid
