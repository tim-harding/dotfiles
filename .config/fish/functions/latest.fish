function latest
    string join0 $argv | sort -z -V | tail -z -n 1
end
