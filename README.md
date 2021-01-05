Based on https://www.atlassian.com/git/tutorials/dotfiles

```
source <(curl -s https://raw.githubusercontent.com/RobCannon/dotfiles/main/.local/bin/init-dotfiles)
```

And, to get repos
```
gh auth login
source <(curl -s https://raw.githubusercontent.com/RobCannon/dotfiles/main/.local/bin/init-repos.ps1)
```