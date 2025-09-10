function init_cursor
    for doc in ~/.cursor-docs/*.md
        ln -s $doc .
    end
    echo "# Plan" >PLAN.md
    echo "# Notes" >NOTEBOOK.md
end
