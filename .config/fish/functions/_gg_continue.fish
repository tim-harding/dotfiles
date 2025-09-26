function _gg_continue -d "Continue the currently-pending operation"
    set -l rbm rebase rebase-merge -d
    set -l rba rebase rebase-apply -d
    set -l mrg merge MERGE_HEAD -f
    set -l pik cherry-pick CHERRY_PICK_HEAD -f
    set -l rvt revert REVERT_HEAD -f

    for op in rbm rba mrg pik rvt
        echo $$op | read -t cmd gitpath kind

        git rev-parse --git-path $gitpath | read -l path
        or return $status

        if test $kind "$path"
            git $cmd --continue
            return $status
        end
    end

    echo "No operation to continue." >&2
    return 1
end
