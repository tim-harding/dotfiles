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

function neo
    set -x RUST_LOG debug
    set -x RUST_BACKTRACE 1
    set neophyte ~/Documents/personal/neophyte/target/release/neophyte
    set logfile ~/Documents/temp/neophyte_log.txt
    $neophyte --messages $argv &> $logfile &
    disown
    set -e RUST_LOG
    set -e RUST_BACKTRACE
end

function output
    function current
        swaymsg -t get_outputs | jq -r '[.[].name | select(test("HEADLESS"))][0]'
    end

    switch $argv[1]
    case 'print'
        echo $(current)

    case 'create'
        argparse 'r/resolution=?' -- $argv[2..]
        or return
        if set -q _flag_r
            set _flag_r 1200x800
        end

        swaymsg create_output
        set current $(current)
        swaymsg output $current position 0 0
        swaymsg output $current resolution $_flag_r
        swaymsg output $current background \#232634 solid_color
        swaymsg workspace 0 output $current

    case 'delete'
        swaymsg output $(current) unplug

    case 'show'
        wl-mirror $(current) &
        disown

    case '*'
        return
    end
end

function houdini_license_restart
    # Note:
    # To prevent license issues due to computer name changing when switching networks:
    # sudo scutil --set HostName yourmachinename
    # sudo scutil --set LocalHostName yourmachinename
    sudo launchctl unload /Library/LaunchDaemons/com.sidefx.sesinetd.plist
    sudo launchctl load -w /Library/LaunchDaemons/com.sidefx.sesinetd.plist
end

function houdini
    # Note to self:
    #
    # OpenGL and OpenCL seems to be working at this point, but Vulkan is still and
    # issue because it crashes when I try switching to the Mesa drivers. 
    #
    # Maybe the Git mesa drivers have fixes?

    # Set up Vulkan. Based on vk_pro script.
    set ICD_DIR "/usr/share/vulkan/icd.d"
    # radv/radeonsi/mesa (seems to crash)
    # set --export VK_DRIVER_FILES "$ICD_DIR/radeon_icd.i686.json" "$ICD_DIR/radeon_icd.x86_64.json"
    # amdgpu-pro (Vulkan could not be initialized)
    # set --export VK_DRIVER_FILES "$ICD_DIR/amd_pro_icd32.json" "$ICD_DIR/amd_pro_icd64.json"
    # amkvlk (Vulkan could not be initialized)
    # set --export VK_DRIVER_FILES "$ICD_DIR/amd_icd32.json" "$ICD_DIR/amd_icd64.json" 

    # Set up OpenGL. Based on progl script.
    set --export --append LD_LIBRARY_PATH "/opt/amdgpu/lib/"
    # set --export --append LD_LIBRARY_PATH "/usr/lib/amdgpu-pro/" # Using this slows down rendering

    # Set up OpenCL
    set --export DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1 1
    set --export RUSTICL_ENABLE radeonsi

    # Fix for Wayland
    set --export QT_QPA_PLATFORM xcb

    #fish_add_path /home/tim/Documents/installs/cycles/install
    #set --export PXR_PLUGINPATH_NAME /home/tim/Documents/installs/cycles/install/houdini/dso/usd_plugins
    /opt/hfs20.5/bin/hindie
end

set -l commands print create delete show
set -l create_command create
complete -c output --no-files
complete -c output -n "not __fish_seen_subcommand_from $commands" -a print -d 'Print the current output'
complete -c output -n "not __fish_seen_subcommand_from $commands" -a create -d 'Create a new output'
complete -c output -n "not __fish_seen_subcommand_from $commands" -a delete -d 'Delete the current output'
complete -c output -n "not __fish_seen_subcommand_from $commands" -a show -d 'Show the current output in a window'
complete -c output -n "__fish_seen_subcommand_from create" -a '-r --resolution'
complete -c output -s r -l resolution -ra '1200x800' -d 'Sets the output resolution'

function exercism_prolog_test
    set test_dir $(basename $PWD)
    swipl -t halt -g "[$test_dir]" -s {$test_dir}_tests.plt -g "run_tests" -- --all
end

alias vi='nvim'
alias vim='nvim'
set fish_greeting
set --export TERM xterm-256color
set --export EDITOR nvim

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

# if not test -e ~/.gemrc
#     ln -s ~/.config/ruby/.gemrc ~/.gemrc
# end

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
