#!/bin/bash
set -e

PROJECT_PATH="$1"
SCENARIO="$2"
SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"

if [ -z "$PROJECT_PATH" ] || [ -z "$SCENARIO" ]; then
    echo "Usage: bash init-wiki.sh <project-path> <scenario: personal|organizational> [extra-dirs...]"
    echo "Example: bash init-wiki.sh ~/my-wiki personal raw/podcasts wiki/entities"
    echo ""
    echo "Base directories created by scenario:"
    echo "  personal:       raw/, wiki/, wiki/concepts/, wiki/cases/"
    echo "  organizational: raw/, wiki/, wiki/concepts/, wiki/cases/, wiki/outputs/"
    echo ""
    echo "Pass extra directories as additional arguments based on interview results."
    exit 1
fi

if [ "$SCENARIO" != "personal" ] && [ "$SCENARIO" != "organizational" ]; then
    echo "Error: scenario must be 'personal' or 'organizational'"
    exit 1
fi

echo "Creating wiki project at: $PROJECT_PATH"
echo "Scenario: $SCENARIO"
echo ""

# Create base directories (minimal viable structure)
mkdir -p "$PROJECT_PATH"/raw
mkdir -p "$PROJECT_PATH"/wiki

# Create essential wiki subdirectories
mkdir -p "$PROJECT_PATH"/wiki/concepts
mkdir -p "$PROJECT_PATH"/wiki/cases

if [ "$SCENARIO" = "organizational" ]; then
    mkdir -p "$PROJECT_PATH"/wiki/outputs
fi

# Create extra directories passed as arguments (based on interview results)
shift 2
for dir in "$@"; do
    mkdir -p "$PROJECT_PATH"/"$dir"
    echo "  + extra dir: $dir"
done

# Add .gitkeep to all directories so they're tracked by git
find "$PROJECT_PATH" -type d -empty -exec touch {}/.gitkeep \;

# Copy template files
cp "$SKILL_DIR/assets/bootstrap-agents.md" "$PROJECT_PATH/AGENTS.md"
cp "$SKILL_DIR/assets/readme-template.md" "$PROJECT_PATH/README.md"
cp "$SKILL_DIR/assets/gitignore-template" "$PROJECT_PATH/.gitignore"
cp "$SKILL_DIR/assets/index-template.md" "$PROJECT_PATH/wiki/index.md"
cp "$SKILL_DIR/assets/log-template.md" "$PROJECT_PATH/wiki/log.md"

echo ""
echo "✓ Base directory structure created"
echo "✓ .gitkeep files added to empty directories"
echo "✓ Template files copied"
echo ""
echo "Created structure:"
find "$PROJECT_PATH" -type d | sort | sed 's|'"$PROJECT_PATH"'||' | head -20
echo ""
echo "Next steps:"
echo "  1. Open the project in your AI coding tool"
echo "  2. The AGENTS.md is in bootstrap state — the easy-wiki skill will trigger onboarding"
echo "  3. Follow the interview process to customize your knowledge base"
echo "  4. The Agent will create additional directories based on your interview answers"
