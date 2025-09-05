function sauce
    for f in ~/.config/fish/{conf.d,functions,completions}/*.fish
        test -L $f # Is it a symlink?
        and source $f
    end
end
