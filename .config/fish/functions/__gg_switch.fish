function __gg_switch -d 'Switch branches with fuzzy search'
    git branch --all --format '%(refname:short)' | fzf | read -l branch
    and git switch $branch
end
