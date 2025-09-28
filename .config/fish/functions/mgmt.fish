function mgmt --argument-names cmd
    set -l rest $argv
    set --erase rest[1]

    set -l inner _mgmt_$cmd

    if test (count $rest) -ge 1
        set -l provider $rest[1]
        set -l nested (echo -s $inner _ $provider)
        set -l nested_args $rest
        set --erase nested_args[1]

        if functions -q $nested
            $nested $nested_args
            return
        end
    end

    if functions -q $inner
        $inner $rest
    else
        echo $cmd not found >&2
        return 1
    end
end

if functions -q complete_subcommand_functions
    complete_subcommand_functions mgmt
end




