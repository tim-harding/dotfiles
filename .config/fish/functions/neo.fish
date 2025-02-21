function neo
    set neophyte ~/.rust-target/release/neophyte
    set --export RUST_LOG neophyte
    set --export RUST_BACKTRACE 1
    $neophyte --messages $argv &
    disown
end
