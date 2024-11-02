function sauce
    source ~/.config/fish/config.fish
    for f in ~/.config/fish/conf.d/*.fish
        source $f
    end
end
