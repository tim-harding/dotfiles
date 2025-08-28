function _gg_clone -d 'Clone with a worktree folder'
    string match --regex --quiet '\/(?<name>[^\/]+)\.git' $argv

    if test -d $name
        echo 'Already cloned'
        cd $name/trunk
        return
    end

    git clone $argv
    mv $name trunk
    mkdir $name
    mv trunk $name
    cd $name/trunk
end
