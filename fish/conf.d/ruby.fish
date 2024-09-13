if not test -e ~/.gemrc
    ln -s ~/.config/ruby/.gemrc ~/.gemrc
end

fish_add_path ~/.local/share/gem/ruby/3.0.0/bin
fish_add_path "$(gem environment | rg "EXECUTABLE DIRECTORY" | sd '.*: (.*)' '$1')"
