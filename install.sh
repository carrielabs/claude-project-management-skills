#!/bin/bash

# Claude Project Management Skills - Installation Script
# Version: 2.0.0

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Base URL
BASE_URL="https://raw.githubusercontent.com/carrielabs/claude-project-management-skills/main/skills"

# Available skills
SKILLS=(
    "documentation-enforcer"
    "code-structure-enforcer"
    "requirement-sync-manager"
    "test-case-sync-engine"
    "test-automation-engine"
    "database-health-monitor"
)

# Function to print colored output
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${YELLOW}ℹ${NC} $1"
}

# Function to install a skill
install_skill() {
    local skill=$1
    local target_dir=$2
    local skill_file="${target_dir}/${skill}.md"
    local source_url="${BASE_URL}/${skill}/SKILL.md"

    print_info "Installing ${skill}..."

    if curl -f -s -o "${skill_file}" "${source_url}"; then
        print_success "${skill} installed successfully"
        return 0
    else
        print_error "Failed to install ${skill}"
        return 1
    fi
}

# Function to show usage
show_usage() {
    cat << EOF
Claude Project Management Skills - Installation Script

Usage:
    ./install.sh [OPTIONS] [SKILLS...]

Options:
    -g, --global        Install to global directory (~/.claude/skills/)
    -p, --project       Install to project directory (./.claude/skills/)
    -a, --all           Install all skills
    -l, --list          List available skills
    -h, --help          Show this help message

Skills:
    documentation-enforcer      Documentation management with naming conventions
    code-structure-enforcer     Code organization and deprecation workflow
    requirement-sync-manager    Single Source of Truth for requirements
    test-case-sync-engine       Automatic test case generation
    test-automation-engine      Intelligent test execution
    database-health-monitor     Automated database maintenance

Examples:
    # Install all skills globally
    ./install.sh --global --all

    # Install specific skills to project
    ./install.sh --project requirement-sync-manager test-case-sync-engine

    # Install single skill globally
    ./install.sh -g documentation-enforcer

    # List available skills
    ./install.sh --list

EOF
}

# Function to list skills
list_skills() {
    echo "Available Skills:"
    echo ""
    for skill in "${SKILLS[@]}"; do
        echo "  • ${skill}"
    done
    echo ""
    echo "Use './install.sh --help' for installation instructions"
}

# Parse arguments
INSTALL_GLOBAL=false
INSTALL_PROJECT=false
INSTALL_ALL=false
SKILLS_TO_INSTALL=()

while [[ $# -gt 0 ]]; do
    case $1 in
        -g|--global)
            INSTALL_GLOBAL=true
            shift
            ;;
        -p|--project)
            INSTALL_PROJECT=true
            shift
            ;;
        -a|--all)
            INSTALL_ALL=true
            shift
            ;;
        -l|--list)
            list_skills
            exit 0
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            SKILLS_TO_INSTALL+=("$1")
            shift
            ;;
    esac
done

# Validate arguments
if [ "$INSTALL_GLOBAL" = false ] && [ "$INSTALL_PROJECT" = false ]; then
    print_error "Please specify installation location: --global or --project"
    echo ""
    show_usage
    exit 1
fi

if [ "$INSTALL_GLOBAL" = true ] && [ "$INSTALL_PROJECT" = true ]; then
    print_error "Cannot install to both global and project directories"
    exit 1
fi

# Determine target directory
if [ "$INSTALL_GLOBAL" = true ]; then
    TARGET_DIR="$HOME/.claude/skills"
    print_info "Installing to global directory: ${TARGET_DIR}"
else
    TARGET_DIR="./.claude/skills"
    print_info "Installing to project directory: ${TARGET_DIR}"
fi

# Create target directory if it doesn't exist
mkdir -p "${TARGET_DIR}"

# Determine which skills to install
if [ "$INSTALL_ALL" = true ]; then
    SKILLS_TO_INSTALL=("${SKILLS[@]}")
elif [ ${#SKILLS_TO_INSTALL[@]} -eq 0 ]; then
    print_error "No skills specified. Use --all or specify skill names"
    echo ""
    show_usage
    exit 1
fi

# Validate skill names
for skill in "${SKILLS_TO_INSTALL[@]}"; do
    if [[ ! " ${SKILLS[@]} " =~ " ${skill} " ]]; then
        print_error "Unknown skill: ${skill}"
        echo ""
        list_skills
        exit 1
    fi
done

# Install skills
echo ""
echo "Installing ${#SKILLS_TO_INSTALL[@]} skill(s)..."
echo ""

SUCCESS_COUNT=0
FAIL_COUNT=0

for skill in "${SKILLS_TO_INSTALL[@]}"; do
    if install_skill "${skill}" "${TARGET_DIR}"; then
        ((SUCCESS_COUNT++))
    else
        ((FAIL_COUNT++))
    fi
done

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Installation Summary:"
echo "  Successful: ${SUCCESS_COUNT}"
echo "  Failed: ${FAIL_COUNT}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ $SUCCESS_COUNT -gt 0 ]; then
    echo ""
    print_success "Skills installed to: ${TARGET_DIR}"
    echo ""
    echo "Next steps:"
    echo "  1. Skills are ready to use with Claude Code"
    echo "  2. Check individual skill README for configuration"
    echo "  3. Add rules to .claude/CLAUDE.md for automatic execution"
fi

if [ $FAIL_COUNT -gt 0 ]; then
    echo ""
    print_error "Some skills failed to install. Check your internet connection."
    exit 1
fi

exit 0
