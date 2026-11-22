# Homebrew Profiles

## Intent

Maintain separate work and personal installed-package lists. Mashu identified the existing Brewfile as work configuration and this computer as personal.

## Approved design

- Rename `homebrew/Brewfile` to `homebrew/Brewfile-work` without changing its contents.
- Export this computer's installed state into `homebrew/Brewfile-personal`, including discoverable VS Code extensions.
- Add `scripts/homebrew.sh snapshot -s personal` and `scripts/homebrew.sh install -s work`, supporting `-s|--settings` with exactly `work` or `personal`.
- Require an explicit profile. Do not infer a profile or provide a default.
- Snapshot replaces only the selected profile's Brewfile.
- Install runs Homebrew Bundle against the selected Brewfile. No cleanup is performed.
- Keep `scripts/install_homebrew.sh` responsible only for installing Homebrew.
- Resolve repository paths relative to the script, not the caller's directory.
- Leave the user's existing `zsh/.zshrc` modification untouched and uncommitted.

## Approaches

1. Snapshot-only script: smaller scope, but does not provide the requested installation entry point.
2. Snapshot and install subcommands: selected by Mashu; keeps profile selection in one place.

The existing installer will not retain package-installation behavior or an alias to the old Brewfile path. No backward compatibility is added.

## Constraints and non-goals

Use Bash and the existing Homebrew CLI. Do not install, upgrade, or remove personal or work packages while developing. Normal use of the install subcommand follows Homebrew Bundle's default install and upgrade behavior. Brewfiles are package lists, not exact-version backups.

Use unit, integration, and end-to-end tests. End-to-end tests must use real Homebrew and real installed-state data, not mocked commands. An empty Brewfile may be used as an installation fixture to exercise the real installation entry point without changing installed packages.

## Verification

Exercise valid and invalid arguments, profile isolation, execution outside the repository directory, real snapshot generation, real Bundle installation against an empty fixture, and byte-for-byte preservation of the work list. Confirm that the original installer exits without invoking package installation when Homebrew is already installed.
