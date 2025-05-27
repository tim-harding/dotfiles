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

        case '*'
            echo "Unknown command"
    end
end
