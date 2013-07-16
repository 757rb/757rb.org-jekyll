
# Development Setup

Misc notes on setting up a development environment. Rarely needs to be done, but wanted to document. First, install some dependencies. Use MacPorts or Homebrew as required.

```shell
$ sudo port install optipng
$ sudo port install tidy
$ bundle install
```

Setup git hooks.

```shell
$ echo "#!/usr/bin/env zsh
$(pwd)/tasks/jekyll" > .git/hooks/pre-commit
```

```shell   
$ echo "#!/usr/bin/env zsh
$(pwd)/tasks/deploy" > .git/hooks/post-push
```


# Developing

After all things are installed, consult each file in the tasks directory for development tips. Since we use Bundler bin stubs, make sure to have the local `.bin` folder high in your path. See [rbenv's for recommendations](https://github.com/sstephenson/rbenv/wiki/Understanding-binstubs#adding-project-specific-binstubs-to-path).


# License

Blog content and design are Copyright (c) 2013, 757.rb Ruby Users Group.

