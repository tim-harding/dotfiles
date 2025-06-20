function __gg_stash
    function inner
        git add .
        git stash
    end
    gg with_root inner $argv
end
