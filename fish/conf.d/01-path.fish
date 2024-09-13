fish_add_path ~/.cargo/bin
fish_add_path ~/.ghcup/bin
fish_add_path ~/.local/bin
fish_add_path ~/.dotnet/tools
fish_add_path ~/.bun/bin

switch (uname)
case Linux

case Darwin
    fish_add_path /opt/homebrew/opt/llvm/bin
    fish_add_path /Applications/Sublime\ Merge.app/Contents/SharedSupport/bin
    fish_add_path /Users/tim/.local/share/bob/nvim-bin
end

