function __gg_amend -d 'Amend last commit with all changes'
    function inner
        git add .
        git commit --amend --no-edit
    end
    set --prepend argv inner
    gg with_root inner $argv
end
