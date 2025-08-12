function _gg_trunk -d 'Print the primary branch name'
    set -l trunk (
        git symbolic-ref refs/remotes/origin/HEAD \
        | string match --regex "\w+\$"
    )

    if isatty stdout
        git switch $trunk
    else
        echo $trunk
    end
end
