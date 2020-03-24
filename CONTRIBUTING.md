# Contributing

## Semantic commit messages
Im using [semantic commit messages](https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716).
To enforce them you can add a git hook following [this guide](https://github.com/hazcod/semantic-commit-hook) 
**TL;DR** *type the following curl command in the root project folder*: 
```
curl --fail -o .git/hooks/commit-msg https://raw.githubusercontent.com/hazcod/semantic-commit-hook/master/commit-msg \
  && chmod 500 .git/hooks/commit-msg` .
```
