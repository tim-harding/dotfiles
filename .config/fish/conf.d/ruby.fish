if command -q gem; and command -q rg; and command -q sd
    fish_add_path -g "$(gem environment | rg "EXECUTABLE DIRECTORY" | sd '.*: (.*)' '$1')"
end
