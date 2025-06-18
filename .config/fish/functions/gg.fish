function gg --argument-names cmd
    set --erase argv[1] # Remove cmd
    switch $cmd
        case root
            git rev-parse --show-toplevel

        case with_root
            set -l root (gg root)
            if [ $root = (pwd) ]
                $argv
            else
                cd $root
                $argv
                prevd
            end

        case amend
            function inner
                git add .
                git commit --amend --no-edit
            end
            set --prepend argv inner
            gg with_root inner $argv

        case reset
            set -l n 0
            if test (count $argv) -gt 0
                set n $argv[1]
            end

            function inner --inherit-variable n
                git add .
                git reset --hard HEAD~$n
            end

            gg with_root inner $argv

        case stash
            function inner
                git add .
                git stash
            end
            gg with_root inner $argv

        case worktree
            function inner --argument-names branch
                git pull
                git worktree prune
                if not string match --regex ".*$branch.*" (git branch --list) > /dev/null
                    git branch $branch
                end
                git worktree add ../$branch $branch
                cd ../$branch
            end
            gg with_root inner $argv

        case cull
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

        case '*'
            echo "Unknown command"
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
