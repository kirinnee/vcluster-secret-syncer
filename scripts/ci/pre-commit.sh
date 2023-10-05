#!/usr/bin/env bash

go mod tidy

set -euo pipefail

pre-commit run --all-files -v
