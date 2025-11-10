# List all recipes
default:
    @just --list

# Execute `terraform`
[group('infrastructure')]
[working-directory('infrastructure')]
[positional-arguments]
terraform *args:
    terraform "$@"

# Check the Terraform docs
[group('infrastructure')]
[working-directory('infrastructure')]
check-docs:
    #!/usr/bin/env bash
    set -euxo pipefail
    recursive=$([[ -e modules ]] && echo true || echo false)
    terraform-docs markdown table . \
        --recursive="${recursive}" \
        --output-file=README.md \
        --output-check

# Generate the Terraform docs
[group('infrastructure')]
[working-directory('infrastructure')]
generate-docs:
    #!/usr/bin/env bash
    set -euxo pipefail
    recursive=$([[ -e modules ]] && echo true || echo false)
    terraform-docs markdown table . \
        --recursive="${recursive}" \
        --output-file=README.md

# Lock the Terraform providers
[working-directory('infrastructure')]
lock-providers:
    #!/usr/bin/env bash
    set -euxo pipefail
    terraform providers lock \
        -platform=darwin_amd64 \
        -platform=darwin_arm64 \
        -platform=linux_amd64 \
        -platform=linux_arm64
