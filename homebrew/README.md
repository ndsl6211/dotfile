# Homebrew profiles

`Brewfile-work` and `Brewfile-personal` are independent package lists.
Run the scripts from the repository root, or use their absolute paths from
another directory. Both commands require `-s|--settings work|personal`.

## Snapshot

Record the current computer's Homebrew formulae, casks, taps, and discoverable
VS Code extensions:

```sh
scripts/homebrew.sh snapshot -s personal
scripts/homebrew.sh snapshot -s work
```

Run only the command matching the computer's profile. Snapshot overwrites that
profile's Brewfile without changing the other profile or installing packages.
Review the diff before committing it. A snapshot reflects one computer's
installed state; it does not merge profiles or preserve handwritten options.

## Install

Install Homebrew first if it is not available:

```sh
scripts/install_homebrew.sh
```

Then select the package list:

```sh
scripts/homebrew.sh install -s personal
scripts/homebrew.sh install -s work
```

Installation uses `brew bundle install`, which installs missing packages and
upgrades outdated packages by default. It does not run Bundle cleanup.
Homebrew environment variables still apply, including
`HOMEBREW_BUNDLE_NO_UPGRADE=1`.

The bootstrap script installs Homebrew only. Package installation is handled
by `homebrew.sh install`.

Brewfiles record package names and options, not an exact-version backup.
Platform-specific packages must be installed on a compatible system.

## Tests

With Homebrew and Python 3 available:

```sh
python3 -B -m unittest discover -s tests -p 'test_homebrew.py' -v
bash -n scripts/homebrew.sh scripts/install_homebrew.sh
```

The tests use real Homebrew for snapshots and temporary empty Brewfiles for
installation, without installing or upgrading the profile packages.
