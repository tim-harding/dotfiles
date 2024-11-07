function fish_user_key_bindings
    fish_default_key_bindings
    fzf --fish | source
    bind \cl accept-autosuggestion or forward-char
    bind \ch backward-char
    bind \cj history-prefix-search-forward
    bind \ck history-prefix-search-backward
end
