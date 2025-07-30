function _gg_update --description "Pull and rebase onto primary branch"
    set -l trunk (gg trunk)
    git switch $trunk
    git pull
    git switch -
    git rebase $trunk
end
