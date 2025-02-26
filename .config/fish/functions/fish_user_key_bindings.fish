function fish_user_key_bindings
    fish_default_key_bindings
    if command -q fzf
        fzf --fish | source
    end
end
