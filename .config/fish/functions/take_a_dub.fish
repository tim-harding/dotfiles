function take_a_dub
    function inner
        git add .
        git commit -m $argv
    end
    set --prepend argv inner
    with_git_root $argv
end
