function amend
    function inner
        git add .
        git commit --amend --no-edit
    end
    set --prepend argv inner
    with_git_root $argv
end
