function _gg_hard -d 'Hard reset to last commit'
    set -l n 0
    if test (count $argv) -gt 0
        set n $argv[1]
    end

    git add
    git reset --hard HEAD~$n
end
