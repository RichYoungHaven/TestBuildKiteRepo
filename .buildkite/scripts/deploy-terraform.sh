#!/bin/bash
set -euo pipefail

cd infra

# run terraform deploy
make build
make deploy

# cleanup artifacts
rm -f "${ENV}.${AWS_DEFAULT_REGION}.plan"