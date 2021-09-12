## Introduction

This is a git repository to keep most of my dotfiles. I've chosen to use
[chezmoi](https://www.chezmoi.io) instead of the popular [bare git repository
method](https://news.ycombinator.com/item?id=11070797) that I was using earlier. The primary reason
for switching to `chezmoi` was managing secrets and other sensitive information that I didn't want
to upload publicly but still wanted to keep in a public git repository. The other alternative I
considered was [yadm](https://yadm.io/) but I couldn't find any information about how to manage
secrets using my password manager, [pass](https://www.passwordstore.org/), when using `yadm`.

## Software

You'll find config files for

- [sway](https://github.com/ayushnix/dotfiles/blob/master/private_dot_config/sway/config)
- [i3status-rust](https://github.com/ayushnix/dotfiles/blob/master/private_dot_config/i3status-rust/config.toml)
- [fish](https://github.com/ayushnix/dotfiles/blob/master/private_dot_config/private_fish/config.fish)
- [alacritty](https://github.com/ayushnix/dotfiles/blob/master/private_dot_config/alacritty/alacritty.yml)
- [neovim](https://github.com/ayushnix/dotfiles/blob/master/private_dot_config/nvim/init.vim)
- [tmux](https://github.com/ayushnix/dotfiles/blob/master/private_dot_config/tmux/tmux.conf)
- [starship](https://github.com/ayushnix/dotfiles/blob/master/private_dot_config/starship.toml)

There's other config stuff as well and some [simple
scripts](https://github.com/ayushnix/dotfiles/tree/master/private_dot_local/private_bin).

## Screenshots

These screenshots should give you a decent idea of what my desktop looks like. I'm not a fan of
pointlessly tinkering with my desktop like some people on a certain subreddit do. I prefer
functionality and usefulness over hollow aesthetics.

![desktop screenshot terminal](https://raw.githubusercontent.com/ayushnix/dotfiles/master/desktop-screenshot.png)
