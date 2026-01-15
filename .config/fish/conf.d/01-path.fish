fish_add_path -g /usr/bin
fish_add_path -g ~/.cargo/bin
fish_add_path -g ~/.ghcup/bin
fish_add_path -g ~/.local/bin
fish_add_path -g ~/.dotnet/tools
fish_add_path -g ~/.bun/bin
fish_add_path -g ~/Documents/installs/glsl_analyzer/zig-out/bin
fish_add_path -g ~/.nix-profile/bin

if command -q go
    fish_add_path -g (go env GOPATH)/bin
end

switch $platform
    case Darwin
        fish_add_path -g /opt/homebrew/bin
        fish_add_path -g /opt/homebrew/opt/curl/bin
        fish_add_path -g /opt/homebrew/opt/llvm/bin
        fish_add_path -g /Applications/Sublime\ Merge.app/Contents/SharedSupport/bin
        fish_add_path -g /Users/tim/.local/share/bob/nvim-bin

        set -l idea_dir "/Applications/IntelliJ IDEA.app/Contents/MacOS"
        if test -d $idea_dir
            fish_add_path -g $idea_dir
        end
end
