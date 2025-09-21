function _gg_amend -d 'Amend last commit with all changes'
    git all
    if git diff --cached --quiet
        git commit --amend
    else
        git commit --amend --no-edit
    end
end
