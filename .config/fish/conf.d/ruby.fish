fish_add_path -xg "$(gem environment | rg "EXECUTABLE DIRECTORY" | sd '.*: (.*)' '$1')"
