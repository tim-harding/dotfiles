function __gg_amend
    function inner
        git add .
        git commit --amend --no-edit
    end
    set --prepend argv inner
    gg with_root inner $argv
end
