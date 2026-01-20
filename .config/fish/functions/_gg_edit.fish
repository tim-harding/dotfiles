function _gg_edit --argument-names commit -d 'start interactive rebase to edit a commit'
    if test -z "$commit"
        echo "Usage: gg edit <commit_hash>" >&2
        return 1
    end

    set parent (git rev-parse $commit^)
    if test $status -ne 0
        return 1
    end

    env GIT_SEQUENCE_EDITOR="sed -i '' '0,/^pick /s//edit /'" \
        git rebase -i $parent
end
