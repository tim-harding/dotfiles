function _gg_trunk -d 'Print the primary branch name'
    set -l trunk

    # Try to get the default branch from symbolic-ref first
    set -l symref (git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null)
    if test $status -eq 0
        set trunk (echo $symref | string match --regex "\w+\$")
    end

    # Fallback: try rev-parse if symbolic-ref failed or returned empty
    if test -z "$trunk"
        set -l rev_parse_result (git rev-parse --abbrev-ref origin/HEAD 2>/dev/null | string replace 'origin/' '')
        if test -n "$rev_parse_result" -a "$rev_parse_result" != "HEAD"
            set trunk $rev_parse_result
        end
    end

    # Final fallback: check common branch names
    if test -z "$trunk"
        for branch in main master trunk
            if git show-ref --verify --quiet refs/remotes/origin/$branch
                set trunk $branch
                break
            end
        end
    end

    if test -z "$trunk"
        echo "Could not determine trunk branch" >&2
        return 1
    end

    if isatty stdout
        git switch $trunk
    else
        echo $trunk
    end
end
