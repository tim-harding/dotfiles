function reset-hard
    function inner
        git add .
        git reset --hard
    end
    set --prepend argv inner
    with_git_root $argv
end
