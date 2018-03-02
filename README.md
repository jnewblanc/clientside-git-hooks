# clientside-git-hooks
This is a collection of scripts that provide client side git hook functionality

## Git hook wrapper functionality
* Calls individual hook scripts in the corresponding -scripts folder
* All tests to run, even if one fails
* Ability to disable all tests, particular test types, or specific tests

# Requires
git => 2.9 (core.hookspath does not work with earlier versions)

## How to use - Setup

### One time setup
* One time setup to allow local githooks to be run from the .githooks directory:
```git config core.hookspath .githooks
```

## Enabling and disabling tests
* All tests can be enabled/disabled as follows:
```git config --global hooks.disable.all true
```
* All precommit tests can be enabled/disabled as follows:
```git config --global hooks.disable.pre-commit true
```
* Individual tests can be enabled/disabled as follows:
```git config --global hooks.disable.<onehook> true
```

## Structure
* .githooks - main hook directory which contains the wrappers
* .githooks/<wrapper>-scripts - directory containing individual hook scripts
* .githooks/tests - Some info on how to test these scripts
