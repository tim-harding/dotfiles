function _gg_clone -d 'Clone with a worktree folder'
    switch (count $argv)
        case 1
            string match --regex --quiet \
                '^(git@|https://)(?<domain>[^:]+)[:/](?<user>[^/]+)/(?<repo>[^\.]+)\.git$' \
                -- $argv
            or begin
                echo "Invalid SSH URI" >&2
                return 1
            end

        case 2
            set -l domain github.com
            set -q GG_CLONE_DOMAIN_DEFAULT
            and set domain $GG_CLONE_DOMAIN_DEFAULT

            set -l user $argv[1]
            set -l repo $argv[2]

        case 3
            set -l domain $argv[1]
            set -l user $argv[2]
            set -l repo $argv[3]

        case *
            echo "Expected 1, 2, or 3 arguments" >&2
            return 1
    end

    set -l uri git@$domain:$user/$repo.git
    set -l dir ~/code/$domain/$user/$repo

    git ls-remote --symref $uri HEAD \
        | string match --regex --quiet '^ref: refs/heads/(?<branch>\w+)'
    or begin
        echo "Failed to get remote branch name" >&2
        return 1
    end

    test -d $dir
    or git clone $uri $dir

    cd $dir
end
