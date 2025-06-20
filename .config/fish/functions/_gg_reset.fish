function _gg_reset -d 'Reset hard to last commit'
    set -l n 0
    if test (count $argv) -gt 0
        set n $argv[1]
    end

    gg with_root __gg_reset_inner $n
end

function __gg_reset_inner --argument-names n
    git add .
    git reset --hard HEAD~$n
end
