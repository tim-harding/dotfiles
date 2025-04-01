if command -q gem; and command -q rg
    fish_add_path -g "$(gem environment | rg "EXECUTABLE DIRECTORY" | sd '.*: (.*)' '$1')"
end
