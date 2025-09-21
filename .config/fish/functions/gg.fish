function gg --argument-names cmd
    set --erase argv[1]
    set -l inner _gg_$cmd
    if functions -q $inner
        $inner $argv
    else
        echo $cmd not found >&2
        return 1
    end
end
