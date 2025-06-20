function repo
    set -l base ~/code
    path basename $base/* | fzf | read -l repo
    and cd $base/$repo/trunk
end
