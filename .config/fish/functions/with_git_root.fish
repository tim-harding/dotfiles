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
