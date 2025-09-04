function _gg_amend -d 'Amend last commit with all changes'
    # TODO: Amend the message if there are no changes
    gg with_root __gg_amend_inner $argv
end

function __gg_amend_inner
    git add .
    git commit --amend --no-edit
end
