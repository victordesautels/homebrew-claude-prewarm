# homebrew-claude-prewarm

A [Homebrew](https://brew.sh) tap for [`claude-prewarm`](https://github.com/victordesautels/claude-prewarm) —
a macOS tool that keeps Claude's 5-hour usage windows aligned to your workday.

## Install

```sh
brew install victordesautels/claude-prewarm/claude-prewarm
```

That one command works with no prior `brew tap` — Homebrew resolves
`user/repo/formula` automatically. Equivalent long form:

```sh
brew tap victordesautels/claude-prewarm
brew install claude-prewarm
```

Then run the one-time guided setup to schedule prewarming:

```sh
claude-prewarm install
```

## Upgrade

```sh
brew upgrade claude-prewarm
```

The launchd agent points at Homebrew's stable `opt` path, so upgrades don't
strand the background schedule.

## Uninstall

Remove the schedule first, then the formula:

```sh
claude-prewarm uninstall -y
brew uninstall claude-prewarm
```
