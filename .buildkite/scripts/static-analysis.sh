#!/bin/bash
set -euo pipefail
cd infra

ls-la

make static_analysis
