function neo
    set neophyte ~/.rust-target/release/neophyte
    set logfile ~/Documents/temp/neophyte/log.txt

    set -l events_files ~/Documents/temp/neophyte/*.json
    string match --regex "\d+" $events_files | sort --reverse | read -l events_last
    or set -l events_last 0
    set -l events_n (math $events_last + 1 | string pad -c 0 -w 4)
    set -l events_file ~/Documents/temp/neophyte/events.$events_n.json

    set --export RUST_LOG neophyte
    set --export RUST_BACKTRACE 1
    $neophyte --tee $events_file --messages $argv &>$logfile &
    disown
end
