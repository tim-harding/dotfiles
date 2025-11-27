function last
    set -l last_count (count $argv)
    if test $last_count -eq 0
        echo ""
    else
        echo $argv[$last_count]
    end
end
