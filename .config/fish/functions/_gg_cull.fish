function _gg_cull -d 'Remove branches' -a branch
    set -l choose \
        gum choose \
        --height 1000 \
        --cursor-prefix '  ' \
        --unselected-prefix '  ' \
        --selected.foreground '' \
        --cursor.foreground '' \
        --header.foreground 4 \
        --no-show-help

    if test -n $branch
        set choice $branch
    else
        set branches (git branch --format '%(refname:short)')
        set options (__gg_cull_format_branches $branches)

        set choice (
            $choose \
                --label-delimiter :: \
                --no-limit \
                --header 'Branches to delete' \
                $options
        )

        if test "$choice" = ''
            return
        end
    end

    set -l confirm ($choose --header "Delete these branches? $choice" no yes force)
    switch $confirm
        case no
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
