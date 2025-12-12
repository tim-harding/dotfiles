function repo
    # Note: $2 -> $3 to use recency instead

    set -l code ~/code
    rg "^$code/([^/]+/[^/]+/[^/]+/[^/\|]+)\|([\d\.]+)\|\d+\$" \
        --no-line-number \
        --color never \
        --replace '$2 $1' \
        ~/.local/share/z/data \
        | sort --reverse \
        | rg '^[\d\.]+ (.*)$' \
        --color never \
        --replace '$1' \
        | fzf --exact --query=$argv \
        | read -l target
    and cd $code/$target
end
