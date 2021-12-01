#!/bin/bash

COOKIE_SECRET=$(python3 -c 'import os,base64; print(base64.urlsafe_b64encode(os.urandom(16)).decode())')
OIDC_CLIENT_ID=$(python3 -c 'import secrets; print(secrets.token_hex(16))')
OIDC_CLIENT_SECRET=$(python3 -c 'import secrets; print(secrets.token_hex(32))')

kubectl create secret generic -n auth oauth2-proxy \
  --from-literal=client-id=${OIDC_CLIENT_ID} \
  --from-literal=client-secret=${OIDC_CLIENT_SECRET} \
  --from-literal=cookie-secret=${COOKIE_SECRET} \
  --dry-run=client -o yaml | kubeseal | yq eval -P \
  > ./oidc-auth/oauth2-proxy-secret.yaml

email="admin@k8s.org"
username=admin
password=admin

ADMIN_PASS_DEX=$(python3 -c "from passlib.hash import bcrypt; print(bcrypt.using(rounds=12, ident='2y').hash(\"${password}\"))")

yq eval ".staticClients[0].id = \"${OIDC_CLIENT_ID}\" | \
  .staticClients[0].secret = \"${OIDC_CLIENT_SECRET}\" | \
  .staticPasswords[0].hash = \"${ADMIN_PASS_DEX}\" | \
  .staticPasswords[0].email = \"${email}\" | \
  .staticPasswords[0].username = \"${username}\"" \
  ./oidc-auth/dex-config-template.yaml | \
  kubectl create secret generic -n auth dex-config --dry-run=client --from-file=config.yaml=/dev/stdin -o yaml | \
  kubeseal | yq eval -P > ./oidc-auth/dex-config-secret.yaml
