function fish_user_key_bindings
    fish_default_key_bindings
    if command -q fzf
        # <C-T> -> files
        # <M-C> -> cd
        fzf --fish | source
    end
end
