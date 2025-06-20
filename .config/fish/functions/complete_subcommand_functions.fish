function complete_subcommand_functions --argument-names command
    complete -c $command --no-files

    set -l subcommands (
        functions --names --all \
        | string split ', ' \
        | string match --regex --groups-only (
            echo -s __ $command '_(.*)'
        )
    )

    for subcommand in $subcommands
        functions --details --verbose (echo -s __ $command _ $subcommand) \
        | read -l --line __ __ __ __ description

        complete -c $command \
            -n "not __fish_seen_subcommand_from $subcommands" \
            -a $subcommand \
            -d $description
    end
end
