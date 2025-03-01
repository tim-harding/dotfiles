set -l commands root with_root amend reset stash
set -l command complete -c gg -n "not __fish_seen_subcommand_from $commands" -a
complete -c gg --no-files
$command root -d 'Print path to git root'
$command with_root -d 'Run function from git root'
$command amend -d 'Amend last commit with all changes'
$command reset -d 'Reset hard to last commit'
$command stash -d 'Create a stash with all changes'
