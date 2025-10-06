function _gg_cull -d 'Remove branches' -a branch
    if test -n $branch
        set choice $branch
    else
        set branches (git branch --format '%(refname:short)')
        set options (__gg_cull_format_branches $branches)

        set choice (
            printf '%s\n' $options \
                | fzf --multi \
                      --ansi \
                      --header 'Branches to delete (TAB to select multiple)' \
                      --delimiter :: \
                      --with-nth 1 \
                | string split -f 2 ::
        )

        if test "$choice" = ''
            return
        end
    end

    echo "Delete these branches? $choice"
    echo "1) no"
    echo "2) yes"
    echo "3) force"
    read -P "Choice [1]: " confirm_choice
    set -q confirm_choice[1]; or set confirm_choice 1
    
    switch $confirm_choice
        case 1 no
            return
        case 2 yes
            set confirm yes
        case 3 force
            set confirm force
        case '*'
            return
    end

    for branch in $choice
        set -l dir (gg dir_worktree $branch)

        test -z $dir
        and break

        test -d $dir
        and rm -rf $dir

        while test (count $dir/*) -eq 0
            test -d $dir
            and rm -r $dir
            set dir (path dirname $dir)
        end
    end

    git worktree prune
    switch $confirm
        case yes
            git branch --delete $choice
        case force
            git branch -D $choice
    end
end

function __gg_cull_format_branches
    for branch in $argv
        __gg_cull_format_branch $branch
    end
end

function __gg_cull_format_branch --argument-names branch
    set -l head (path dirname  $branch)
    set -l tail (path basename $branch)
    switch $head
        case '.'
            echo -n $branch
        case '*'
            set_color brblack
            echo -n $head/
            set_color normal
            echo -n $tail
    end
    echo -s :: $branch
end
