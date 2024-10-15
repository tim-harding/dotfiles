function git_root
    git rev-parse --show-toplevel
end

function with_git_root
    git_root | read root
    if [ $root = $(pwd) ]
        $argv
    else
        cd $root
        $argv
        prevd
    end
end

function take_a_dub
    function inner
        git add . 
        git commit -m $argv
    end
    set --prepend argv inner
    with_git_root $argv
end

function reset-hard
    function inner
        git add .
        git reset --hard
    end
    set --prepend argv inner
    with_git_root $argv
end

function amend
    function inner
        git add .
        git commit --amend --no-edit
    end
    set --prepend argv inner
    with_git_root $argv
end
