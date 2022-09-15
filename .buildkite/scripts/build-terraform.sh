#!/bin/bash
set -euo pipefail

cd infra

# download plan to artifacts

#mkdir package
#buildkite-agent artifact download "deploy-package.zip" "package"


# run terraform plan
make build

# upload plan to artifacts
buildkite-agent artifact upload "${ENV}.${AWS_DEFAULT_REGION}.plan"
rm -f "${ENV}.${AWS_DEFAULT_REGION}.plan"