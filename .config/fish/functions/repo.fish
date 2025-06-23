function repo
    set -l base ~/code
    path basename $base/* | fzf --select-1 --query $argv | read -l repo
    and cd $base/$repo/trunk
end
