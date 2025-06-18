set -l commands repo branch
complete -c goto --no-files
for command in $commands
    complete -c goto -n "not __fish_seen_subcommand_from $commands" -a $command
end
