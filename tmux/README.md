# tmux configuration

This directory contains my personal `tmux` configuration.

## Features
- Window numbering starts from 1.
- Pane numbering starts from 1.
- Mouse support is enabled.
- Quick window switching using `Alt + [0-9]`.

## Installation

To install this configuration, run the installation script from the project root:

```bash
./scripts/install_tmux.sh
```

To replace an existing configuration:

```bash
./scripts/install_tmux.sh --replace
```

## Sourcing Configuration

After installation or modification, you can reload the configuration within `tmux` by running:

```bash
tmux source-file ~/.tmux.conf
```
