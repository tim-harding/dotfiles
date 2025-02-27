function neo
    set neophyte ~/.rust-target/release/neophyte
    $neophyte --messages $argv &
    disown
end
