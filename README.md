# Dotfiles

Personal dotfiles and configuration. Most of these are for my Arch Linux setup, but some also apply to cross-platform software, notably my Neovim and Fish configurations.

## Setup

```sh
cd ~
gh clone tim-harding/dotfiles
stow . --no-folding
```

## Manual steps

### Firefox

Enable in `about:config`

- `media.ffmpeg.vaapi.enabled`
- `gfx.webrender.all`
- `gfx.webrender.compositor`

### Chromium

In `chrome://flags`, set Preferred Ozone Platform to Wayland
