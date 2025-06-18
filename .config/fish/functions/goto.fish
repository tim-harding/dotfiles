function goto --argument-names cmd
    switch $cmd
        case branch
            git branch --all --format '%(refname:short)' | fzf | read -l branch
            and git switch $branch

        case repo
            set -l base ~/Documents/code
            path basename $base/* | fzf | read -l repo
            and cd $base/$repo/primary

        case '*'
            echo Unknown command $cmd >&2
            return -1
    end
end
