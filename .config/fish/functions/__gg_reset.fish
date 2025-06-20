function __gg_reset
    set -l n 0
    if test (count $argv) -gt 0
        set n $argv[1]
    end

    function inner --inherit-variable n
        git add .
        git reset --hard HEAD~$n
    end

    gg with_root inner $argv
end
