function _gg_soft -d 'soft reset to last commit'
    set -l n 0
    if test (count $argv) -gt 0
        set n $argv[1]
    end

    git all
    git reset --soft HEAD~$n
    git reset .
end
