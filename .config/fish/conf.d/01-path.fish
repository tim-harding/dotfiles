fish_add_path --global /usr/bin
fish_add_path --global ~/.cargo/bin
fish_add_path --global ~/.ghcup/bin
fish_add_path --global ~/.local/bin
fish_add_path --global ~/.dotnet/tools
fish_add_path --global ~/.bun/bin
fish_add_path --global ~/Documents/installs/glsl_analyzer/zig-out/bin

switch (uname)
    case Darwin
        fish_add_path --global /opt/homebrew/opt/llvm/bin
        fish_add_path --global /Applications/Sublime\ Merge.app/Contents/SharedSupport/bin
        fish_add_path --global /Users/tim/.local/share/bob/nvim-bin
end
