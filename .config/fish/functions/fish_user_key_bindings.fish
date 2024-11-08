function fish_user_key_bindings
    fish_default_key_bindings
    fzf --fish | source
    bind \cl accept-autosuggestion or nextd-or-forward-word
    bind \ch prevd-or-backward-word
    bind \el forward-char
    bind \eh backward-char
    bind \cj history-prefix-search-forward
    bind \ck history-prefix-search-backward
end
