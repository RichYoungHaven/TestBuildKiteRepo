#!/bin/bash
set -euo pipefail
cd infra

# download plan to artifacts ##### No software code in this example so not required
#mkdir package
#buildkite-agent artifact download "deploy-package.zip" "package"

# run terraform test
make test