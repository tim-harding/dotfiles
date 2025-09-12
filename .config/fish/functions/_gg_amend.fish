function _gg_amend -d 'Amend last commit with all changes'
    gg with_root __gg_amend_inner $argv
end

function __gg_amend_inner
    git add .
    if git diff --cached --quiet
        git commit --amend
    else
        git commit --amend --no-edit
    end
end
