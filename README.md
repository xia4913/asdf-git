<div align="center">

# asdf-git ![Build](https://github.com/xia4913/asdf-git/workflows/Build/badge.svg) ![Lint](https://github.com/xia4913/asdf-git/workflows/Lint/badge.svg)

[git](https://git-scm.com/doc) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add git
# or
asdf plugin add https://github.com/xia4913/asdf-git.git
```

git:

```shell
# Show all installable versions
asdf list-all git

# Install specific version
asdf install git latest

# Set a version globally (on your ~/.tool-versions file)
asdf global git latest

# Now git commands are available
git --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/xia4913/asdf-git/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Ogawa Takanori](https://github.com/xia4913/)
