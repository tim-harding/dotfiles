function take_a_dub
    function inner
        git add .
        if test (count $argv) -eq 0
            git commit
        else
            git commit -m "$argv"
        end
    end
    gg with_root inner $argv
end
