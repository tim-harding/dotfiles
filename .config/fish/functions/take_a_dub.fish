function take_a_dub
    function inner
        git add .
        git commit -m $argv
    end
    gg with_root inner $argv
end
