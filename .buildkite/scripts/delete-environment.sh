#!/bin/bash

set -eu

# retrieve environment and queue
ENV_ACC=$(buildkite-agent meta-data get "environmentAccount")
echo "Selection was ${ENV_ACC}"

IFS=',' read -r ENV_NAME AWS_ACCOUNT <<< "${ENV_ACC}"

# create buildkite step to run destroy for the selected environment
cat << EOF | buildkite-agent pipeline upload
  - block: "Delete environment ${AWS_ACCOUNT} ${ENV_NAME}"
  - label: "Delete environment ${AWS_ACCOUNT} ${ENV_NAME} :terraform:"
    command: |
      cd infra
      mkdir package
      echo UEsFBgAAAAAAAAAAAAAAAAAAAAAAAA== | base64 -d > package/deploy-package.zip
      make delete
    env:
      account: "${AWS_ACCOUNT}"
    agents:
      queue: ${AWS_ACCOUNT}.linux
EOF
