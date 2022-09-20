#!/bin/bash
set -euo pipefail
cd infra

make -d static_analysis
