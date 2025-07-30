function _gg_trunk -d 'Print the primary branch name'
    git symbolic-ref refs/remotes/origin/HEAD \
        | string match --regex "\w+\$"
end
