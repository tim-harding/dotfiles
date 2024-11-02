set -l commands print create delete show
set -l create_command create
complete -c output --no-files
complete -c output -n "not __fish_seen_subcommand_from $commands" -a print -d 'Print the current output'
complete -c output -n "not __fish_seen_subcommand_from $commands" -a create -d 'Create a new output'
complete -c output -n "not __fish_seen_subcommand_from $commands" -a delete -d 'Delete the current output'
complete -c output -n "not __fish_seen_subcommand_from $commands" -a show -d 'Show the current output in a window'
complete -c output -n "__fish_seen_subcommand_from create" -a '-r --resolution'
complete -c output -s r -l resolution -ra 1200x800 -d 'Sets the output resolution'
