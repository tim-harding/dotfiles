function neo
    set -x RUST_LOG debug
    set -x RUST_BACKTRACE 1
    set neophyte ~/Documents/personal/neophyte/target/release/neophyte
    set logfile ~/Documents/temp/neophyte_log.txt
    $neophyte --messages $argv &> $logfile &
    disown
    set -e RUST_LOG
    set -e RUST_BACKTRACE
end

alias vi='nvim'
alias vim='nvim'
set fish_greeting
set --export TERM xterm-256color
set --export EDITOR nvim
