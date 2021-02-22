# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test git https://github.com/xia4913/asdf-git.git "git --version"
```

Tests are automatically run in GitHub Actions on push and PR.
