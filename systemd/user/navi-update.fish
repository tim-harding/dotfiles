#!/usr/bin/fish --no-config

navi info cheats-path | read np
for dir in $(exa "$np" --only-dirs);
    set p "$np/$dir"
    cd "$p"
    git pull &> /dev/null
    prevd
end
