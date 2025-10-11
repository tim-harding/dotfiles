function mgmt --argument-names cmd
    set --erase argv[1]

    set -l inner _mgmt_$cmd
    if functions -q $inner
        $inner $argv
    else
        echo $cmd not found >&2
        return 1
    end
end

if functions -q complete_subcommand_functions
    complete_subcommand_functions mgmt
end

# Probably want a command to identify overlap between profiles