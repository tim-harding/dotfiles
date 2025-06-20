function __gg_cull -d 'Remove branches'
    set -l branches (git branch --format '%(refname:short)')
    set -l options (__cull_format_branches $branches)
    set -l choose \
        gum choose \
            --height 1000 \
            --cursor-prefix '  ' \
            --unselected-prefix '  ' \
            --selected.foreground '' \
            --cursor.foreground '' \
            --header.foreground 4 \
            --no-show-help

    set -l choice (
        $choose \
            --label-delimiter :: \
            --no-limit \
            --header 'Branches to delete' \
            $options
    )

    if test "$choice" = ''
        return
    end

    set -l confirm ($choose --header "Delete these branches? $choice" no yes force)
    switch $confirm
        case no
        case yes
            git branch --delete $choice
        case force
            git branch -D $choice
    end
end

function __cull_format_branches
    for branch in $argv
        __cull_format_branch $branch
    end
end

function __cull_format_branch --argument-names branch
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
