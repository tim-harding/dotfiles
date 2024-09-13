if not test -e ~/.gemrc
    ln -s ~/.config/ruby/.gemrc ~/.gemrc
end

fish_add_path --global "$(gem environment | rg "EXECUTABLE DIRECTORY" | sd '.*: (.*)' '$1')"
