function _gg_stash -d 'Create a stash with all changes'
    function inner
        git add .
        git stash
    end
    gg with_root inner $argv
end
