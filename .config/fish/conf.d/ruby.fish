if command -q gem; and command -q rg; and command -q sd
    # Disabling for now because of annoying messages when I don't have things
    # properly configured to prefer the Homebrew install over the default MacOS
    # one.
    #
    # fish_add_path -g "$(gem environment | rg "EXECUTABLE DIRECTORY" | sd '.*: (.*)' '$1')"
end
