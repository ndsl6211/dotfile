#!/bin/bash

# ABOUTME: Snapshots and installs Homebrew packages and VS Code extensions by profile

set -e

usage() {
    echo "Usage: $0 <snapshot|install> -s|--settings <work|personal>"
    echo "  snapshot         Replace the selected Brewfile with installed packages"
    echo "  install          Install and upgrade packages from the selected Brewfile"
    echo "  -s, --settings   Select work or personal (required)"
    echo "  -h, --help       Show this help message"
}

fail() {
    echo "Error: $1" >&2
    exit 1
}

if [[ $# -eq 0 ]]; then
    fail "Expected snapshot or install. Use --help for usage."
fi

COMMAND="$1"
shift

case "$COMMAND" in
    -h|--help)
        usage
        exit 0
        ;;
    snapshot|install)
        ;;
    *)
        fail "Unknown command: $COMMAND"
        ;;
esac

SETTINGS_VARIANT=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -s|--settings)
            [[ -z "$SETTINGS_VARIANT" ]] || fail "Settings specified more than once."
            [[ $# -ge 2 && "$2" != -* ]] || fail "$1 requires work or personal."
            SETTINGS_VARIANT="$2"
            case "$SETTINGS_VARIANT" in
                work|personal) ;;
                *) fail "Unknown settings: $SETTINGS_VARIANT" ;;
            esac
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            fail "Unknown option: $1"
            ;;
    esac
done

[[ -n "$SETTINGS_VARIANT" ]] || fail "Settings are required. Use -s work or -s personal."
command -v brew > /dev/null 2>&1 || fail "Homebrew is required. Run scripts/install_homebrew.sh first."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILE_ROOT="$(dirname "$SCRIPT_DIR")"
BREWFILE="$DOTFILE_ROOT/homebrew/Brewfile-$SETTINGS_VARIANT"

case "$COMMAND" in
    snapshot)
        exec brew bundle dump --file="$BREWFILE" --force --formula --cask --tap --vscode
        ;;
    install)
        [[ -f "$BREWFILE" ]] || fail "Brewfile not found: $BREWFILE"
        exec brew bundle install --file="$BREWFILE"
        ;;
esac
