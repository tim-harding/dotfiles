function take_a_dub
    git all
    if test (count $argv) -eq 0
        git commit
    else
        git commit -m "$argv"
    end
end
