fish_add_path -g /usr/bin
fish_add_path -g ~/.cargo/bin
fish_add_path -g ~/.ghcup/bin
fish_add_path -g ~/.local/bin
fish_add_path -g ~/.dotnet/tools
fish_add_path -g ~/.bun/bin
fish_add_path -g ~/Documents/installs/glsl_analyzer/zig-out/bin
fish_add_path -g ~/.nix-profile/bin

switch $platform
    case Darwin
        fish_add_path --global /opt/homebrew/opt/llvm/bin
        fish_add_path --global /Applications/Sublime\ Merge.app/Contents/SharedSupport/bin
        fish_add_path --global /Users/tim/.local/share/bob/nvim-bin
end
