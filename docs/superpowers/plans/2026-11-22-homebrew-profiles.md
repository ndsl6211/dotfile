# Homebrew Profiles Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Maintain work and personal Brewfiles through explicit profile-aware snapshot and install commands.

**Architecture:** A Bash entry point resolves a profile-specific Brewfile relative to its own location and delegates package operations to Homebrew Bundle. The existing bootstrap installer only installs Homebrew.

**Tech Stack:** Bash, Homebrew Bundle, Python standard-library unittest for subprocess and temporary-directory testing.

**Spec:** `docs/superpowers/specs/2026-11-22-homebrew-profiles-design.md`

## Global Constraints

- Require `-s|--settings` with exactly `work` or `personal`; no default profile.
- Preserve work Brewfile contents exactly.
- Include discoverable VS Code extensions in snapshots.
- Do not install, upgrade, or remove personal or work packages while developing.
- No cleanup commands, backward compatibility, third-party test dependencies, or mocked end-to-end commands.
- Leave `zsh/.zshrc` untouched and uncommitted.

## Review Focus

- Missing option values, unknown flags, duplicate settings, extra arguments, and invalid subcommands must fail before Homebrew runs.
- Running outside the repository must select the same Brewfile.
- A personal snapshot must not alter the work file.
- Missing Homebrew or a missing install Brewfile must produce an actionable error and nonzero exit.
- Homebrew failures must propagate rather than print success.

## Task 1: Profile command and bootstrap separation

**Files:**
- Create: `scripts/homebrew.sh`
- Modify: `scripts/install_homebrew.sh`
- Create: `tests/test_homebrew.py`

**Interfaces:**
- Consumes: `brew bundle dump --file=<path> --force --vscode` and `brew bundle install --file=<path>`.
- Produces: `homebrew.sh <snapshot|install> -s|--settings <work|personal>` and `-h|--help`.
- Resolves: `<repository>/homebrew/Brewfile-<profile>`.

- [ ] Write unit tests for help, required arguments, accepted profile values, unknown arguments, duplicate settings, and missing option values. Use subprocess execution and captured output; no mocked command assertions.
- [ ] Run `python3 -m unittest discover -s tests -p 'test_homebrew.py' -v`; confirm failures are caused by the missing entry point.
- [ ] Implement argument parsing, repository path resolution, required-file and Homebrew checks, and direct Bundle delegation. Include `--vscode` for snapshots.
- [ ] Add integration and end-to-end cases in temporary repository fixtures containing a copy of the real script. Use the real Homebrew executable for an installed-state snapshot and installation from an empty Brewfile. Compare the work sentinel before and after a personal snapshot; run from an unrelated directory. Capture and assert command output and exit status.
- [ ] Remove package installation from the bootstrap installer, preserving truthful comments and its existing Homebrew installation behavior. Add a test running it with the real installed Homebrew and assert that it exits without package installation.
- [ ] Run the full test file, `bash -n scripts/homebrew.sh scripts/install_homebrew.sh`, and ShellCheck if available. Fix failures before proceeding.
- [ ] Commit only the command, installer, and tests with `feat(homebrew): add profile commands`.

## Task 2: Profile data and usage

**Files:**
- Rename: `homebrew/Brewfile` to `homebrew/Brewfile-work`
- Create: `homebrew/Brewfile-personal`
- Create: `homebrew/README.md`

**Interfaces:**
- Consumes: Task 1 command.
- Produces: work and personal installed-package lists.

- [ ] Add a failing test that checks the original work list against `git show master:homebrew/Brewfile` and verifies both profile files exist.
- [ ] Run the test and confirm that the missing profile files cause failure.
- [ ] Rename the original Brewfile without modifying its contents.
- [ ] Run `scripts/homebrew.sh snapshot -s personal` to generate the personal file using real installed-state data; investigate any discovery failure instead of excluding package categories silently.
- [ ] Document snapshot and install commands, explicit profile selection, snapshot replacement, default installation upgrades, and lack of exact-version restoration.
- [ ] Run all tests and syntax checks. Inspect `git diff --check` and the staged diff; confirm `.zshrc` is not staged. Report observable behavior changes and verification evidence.
- [ ] Commit only profile lists and usage documentation with `feat(homebrew): split package profiles`.

## Execution Notes

No implementation has started. The design was approved in conversation. This plan needs Mashu's review and execution-method selection before implementation.
