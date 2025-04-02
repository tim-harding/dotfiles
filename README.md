# Dotfiles

Personal dotfiles and configuration. Most of these are for my Arch Linux setup, but some also apply to cross-platform software, notably my Neovim and Fish configurations.

## Setup

```sh
# MacOS
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install git stow

cd ~
git clone git@github.com:tim-harding/dotfiles.git
stow . --no-folding --restow --adopt

# MacOS
brew bundle install --file ~/.config/brewfile/Brewfile

sudo sh -c "echo $(which fish) >> /etc/shells"
chsh -s $(which fish)
```

## Manual steps

### Firefox

Enable in `about:config`

- `media.ffmpeg.vaapi.enabled`
- `gfx.webrender.all`
- `gfx.webrender.compositor`

### Chromium

In `chrome://flags`, set Preferred Ozone Platform to Wayland
