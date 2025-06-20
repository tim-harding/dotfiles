function gg --argument-names cmd
    set --erase argv[1]
    __gg_$cmd $argv
end
