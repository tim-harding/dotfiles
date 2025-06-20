function __gg_switch
    git branch --all --format '%(refname:short)' | fzf | read -l branch
    and git switch $branch
end
