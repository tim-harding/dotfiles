function _gg_update --description "Pull and rebase onto primary branch"
    # TODO: Decide whether to use main or master
    git switch master
    git pull
    git switch -
    git rebase master
end
