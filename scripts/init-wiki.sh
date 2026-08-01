#!/bin/bash
set -e

PROJECT_PATH="$1"
SCENARIO="$2"
SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"

if [ -z "$PROJECT_PATH" ] || [ -z "$SCENARIO" ]; then
    echo "Usage: bash init-wiki.sh <project-path> <scenario: personal|organizational>"
    echo "Example: bash init-wiki.sh ~/my-wiki personal"
    exit 1
fi

if [ "$SCENARIO" != "personal" ] && [ "$SCENARIO" != "organizational" ]; then
    echo "Error: scenario must be 'personal' or 'organizational'"
    exit 1
fi

echo "Creating wiki project at: $PROJECT_PATH"
echo "Scenario: $SCENARIO"
echo ""

# Create base directories
mkdir -p "$PROJECT_PATH"/raw
mkdir -p "$PROJECT_PATH"/wiki

# Create scenario-specific directories
if [ "$SCENARIO" = "personal" ]; then
    mkdir -p "$PROJECT_PATH"/raw/articles
    mkdir -p "$PROJECT_PATH"/raw/thoughts
    mkdir -p "$PROJECT_PATH"/wiki/sources
    mkdir -p "$PROJECT_PATH"/wiki/concepts
    mkdir -p "$PROJECT_PATH"/wiki/cases
    mkdir -p "$PROJECT_PATH"/wiki/thoughts
    mkdir -p "$PROJECT_PATH"/wiki/synthesis
    mkdir -p "$PROJECT_PATH"/wiki/outputs
    mkdir -p "$PROJECT_PATH"/wiki/entities
else
    mkdir -p "$PROJECT_PATH"/raw/meetings
    mkdir -p "$PROJECT_PATH"/wiki/concepts
    mkdir -p "$PROJECT_PATH"/wiki/cases
    mkdir -p "$PROJECT_PATH"/wiki/outputs
    mkdir -p "$PROJECT_PATH"/wiki/thoughts
fi

# Copy template files
cp "$SKILL_DIR/assets/bootstrap-agents.md" "$PROJECT_PATH/AGENTS.md"
cp "$SKILL_DIR/assets/readme-template.md" "$PROJECT_PATH/README.md"
cp "$SKILL_DIR/assets/gitignore-template" "$PROJECT_PATH/.gitignore"
cp "$SKILL_DIR/assets/index-template.md" "$PROJECT_PATH/wiki/index.md"
cp "$SKILL_DIR/assets/log-template.md" "$PROJECT_PATH/wiki/log.md"

echo "✓ Directory structure created"
echo "✓ Template files copied"
echo ""
echo "Next steps:"
echo "  1. Open the project in your AI coding tool"
echo "  2. The AGENTS.md is in bootstrap state — the easy-wiki skill will trigger onboarding"
echo "  3. Follow the interview process to customize your knowledge base"
