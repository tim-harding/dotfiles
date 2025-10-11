function ansi_remove
    sed -e 's/\x1b\[[0-9;]*m//g'
end