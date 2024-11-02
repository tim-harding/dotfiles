function neo
    set -x RUST_LOG debug
    set -x RUST_BACKTRACE 1
    set neophyte ~/Documents/personal/neophyte/target/release/neophyte
    set logfile ~/Documents/temp/neophyte_log.txt
    set --export RUST_LOG neophyte
    set --export RUST_BACKTRACE 1
    $neophyte --messages $argv &>$logfile &
    disown
end
