# This is the directory for git local hook testing.

## Setup for local git hooks:
Run the following, which instructs git (2.9+) to look for githooks in the
<repo>/.githook directory.

```git config --global core.hooksPath .githooks
```

One of our pre-commit hooks will block a commits if "FAILTHECOMMIT" string
exists in the content diffs of a file being committed.  Here's some command
line snippets to test that.

* The following should fail before the commit editor comes up

```echo "FAILTHECOMMIT >> failcommit.txt ; git add failcommit.txt; git commit
```

* The following should pass and the commit editor will come up.  You can quit the editor with no content to abort without committing.

```date >> failcommit ; git add failcommit git commit
```
