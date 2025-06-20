function _gg_clone -d 'Clone with a worktree folder'
    string match --regex --quiet '\/(?<name>[^\/]+)\.git' $argv
    git clone $argv
    mv $name trunk
    mkdir $name
    mv trunk $name
end
