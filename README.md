# clientside-git-hooks
A collection of scripts to provide client side git hook functionality.

# How it works
* Individual client side hook scripts reside in the &lt;wrapper&gt;-scripts directory.  (i.e. clientside-git-hooks/.githooks/pre-commit-scripts).
* A wrapper script, calls each of the individual git hook scripts in the &lt;wrapper&gt;-scripts directory.  The wrapper provides consistent output and allows for the disabling of tests.  Tests can be disabled or re-enabled by setting git config options.  All enabled hook tests run, even if one fails.
* Some info about how to test is provided in .githooks/tests 

## Requires
* git => 2.9 (core.hookspath does not work with earlier versions)

## Structure
* .githooks - main hook directory which contains the hook wrappers
* .githooks/&lt;wrapper&gt;-scripts - directory containing individual hook scripts
* .githooks/tests - Directory for info/scripts to test the hook and wrapper functionality

## Setup: How to use clientside-git-hooks

### Installation
* clone this repo
```
git clone https://github.com/jnewblanc/clientside-git-hooks
```
* copy the .githooks directory to your workspace
* edit/delete/add hook scripts in the &lt;wrapper&gt;-scripts directory, to suit your needs

### One time configuration
* The one time setting of the following git config option is required to allow local githooks to be run from the .githooks directory:
```
git config core.hookspath .githooks
```

### Enabling and disabling tests
* All tests can be enabled/disabled as follows:
```
git config --global hooks.disable.all true
```
* All precommit tests can be enabled/disabled as follows:
```
git config --global hooks.disable.pre-commit true
```
* Individual tests can be enabled/disabled as follows:
```
git config --global hooks.disable.<onehook> true
```
