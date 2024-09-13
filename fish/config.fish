function ls
    exa \
    --long \
    --all \
    --git \
    --icons \
    --header \
    --no-user \
    --time-style=long-iso \
    --group-directories-first \
    --level=2 \
    --sort=modified \
    --reverse \
    $argv
end

function mkdir
    # Make intermediate directories automatically
    /usr/bin/env mkdir -p $argv
end

function sauce
    source ~/.config/fish/config.fish
end

function update_all
    switch (uname)
    case Linux
        sudo pacman -Syu --noconfirm
        yay -Syu --noconfirm
    case Darwin
        brew update
        brew upgrade
    end
    rustup update
    bob update --all
    pyenv install $(pyenv latest 3) --skip-existing
    nvim --headless '+Lazy! sync' +qa
    fisher update
    cargo install-update --all
    npm update --global
    bun update --global
    gem update
end

function remove_orphan_packages
    sudo pacman -Rs --noconfirm $(pacman -Qtdq)
end

function exercism_prolog_test
    set test_dir $(basename $PWD)
    swipl -t halt -g "[$test_dir]" -s {$test_dir}_tests.plt -g "run_tests" -- --all
end

set --export RIPGREP_CONFIG_PATH ~/.config/ripgrep/.ripgreprc

fish_add_path ~/.cargo/bin
fish_add_path ~/.ghcup/bin
fish_add_path ~/.local/bin
fish_add_path ~/.dotnet/tools

# opam configuration
source ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# ctrl-g to start
navi widget fish | source

set --export FLYCTL_INSTALL ~/.fly
fish_add_path $FLYCTL_INSTALL/bin

set --export BAT_PAGER
# Colors from https://github.com/catppuccin/fzf
set --export FZF_DEFAULT_OPTS \
    --reverse \
    --inline-info \
    --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
    --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
    --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284

cp ~/.config/misc/.gitconfig ~/.gitconfig

fish_add_path ~/.bun/bin
fish_add_path ~/.local/share/gem/ruby/3.0.0/bin

function path_latest
    string join0 $argv | sort -z -V | tail -z -n 1
end

switch (uname)
case Linux
    xdg-mime default firefox.desktop application/pdf

    set IS_SSH_ADDED $(ps -ef | rg 'ssh-agent' | rg -v 'rg' | wc -l)
    if test $IS_SSH_ADDED -eq 0
        ssh-add
    end

    set --export BROWSER firefox
    set --export VDPAU_DRIVER radeonsi
    set --export LIBVA_DRIVER_NAME radeonsi

    set --erase --global PYTHONPATH

    path_latest /usr/share/blender/*/scripts/modules/ | read PYTHONPATH_BLENDER 
    if not contains -- $PYTHONPATH_BLENDER $PYTHONPATH
        set --export --global --append PYTHONPATH $PYTHONPATH_BLENDER
    end

    path_latest /opt/hfs*/houdini/python*libs | read PYTHONPATH_HOUDINI
    if not contains -- $PYTHONPATH_HOUDINI $PYTHONPATH
        set --export --global --append PYTHONPATH $PYTHONPATH_HOUDINI
    end

case Darwin
    fish_add_path /opt/homebrew/opt/llvm/bin
    fish_add_path /Applications/Sublime\ Merge.app/Contents/SharedSupport/bin
    fish_add_path /Users/tim/.local/share/bob/nvim-bin
    fish_add_path "$(gem environment | rg "EXECUTABLE DIRECTORY" | sd '.*: (.*)' '$1')"

    set TEALDEER_CONFIG_DIR ~/Library/Application\ Support/tealdeer
    set TEALDEER_CONFIG "$TEALDEER_CONFIG_DIR/config.toml"
    mkdir $TEALDEER_CONFIG_DIR 
    rm $TEALDEER_CONFIG 
    ln -s ~/.config/tealdeer/config.toml $TEALDEER_CONFIG
end
