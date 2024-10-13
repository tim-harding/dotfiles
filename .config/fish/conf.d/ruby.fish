fish_add_path --global "$(gem environment | rg "EXECUTABLE DIRECTORY" | sd '.*: (.*)' '$1')"
