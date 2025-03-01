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
            gg with_root $argv

        case reset
            function inner
                git add .
                git reset --hard
            end
            set --prepend argv inner
            gg with_root $argv

        case '*'
            echo "Unknown command"
    end
end
