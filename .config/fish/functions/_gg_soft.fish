function _gg_soft -d 'soft reset to last commit'
    set -l n 0
    if test (count $argv) -gt 0
        set n $argv[1]
    end

    gg with_root __gg_soft_inner $n
end

function __gg_soft_inner --argument-names n
    git add .
    git reset --soft HEAD~$n
end
