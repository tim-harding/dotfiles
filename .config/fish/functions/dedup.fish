function dedup -d "Like uniq except that duplicate lines don't need to be consecutive"
    awk '!seen[$0]++'
end
