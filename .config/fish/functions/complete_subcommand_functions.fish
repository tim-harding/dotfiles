function complete_subcommand_functions --argument-names command
    complete -c $command --no-files

    set -l all_tails (
        functions --names --all \
        | string split ', ' \
        | string match --regex --groups-only (
            echo -s _ $command '_(.*)'
        )
    )

    set -l first_level
    for tail in $all_tails
        set -l head (string split -m1 _ $tail)[1]
        set first_level $first_level $head
    end
    set -l subcommands (printf '%s\n' $first_level | sort -u)

    for subcommand in $subcommands
        set -l sub_fn (echo -s _ $command _ $subcommand)
        functions --details --verbose $sub_fn | read -l --line __ __ __ __ description

        complete -c $command \
            -n "not __fish_seen_subcommand_from $subcommands" \
            -a $subcommand \
            -d $description

        set -l providers (
            functions --names --all \
            | string split ', ' \
            | string match --regex --groups-only (
                echo -s _ $command _ $subcommand '_(.*)'
            )
        )

        if test (count $providers) -gt 0
            complete -c $command \
                -n "__fish_seen_subcommand_from $subcommand" \
                -a "$providers"
        end
    end
end
