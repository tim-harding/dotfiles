function init_cursor
    for doc in ~/.cursor-docs/*.md
        ln -s $doc .
    end
end
