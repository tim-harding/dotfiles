function _gg_pr-description -d 'Generate JIRA ticket link from branch name'
    set -l branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if test $status -ne 0
        echo "Not in a git repository" >&2
        return 1
    end

    # Extract ticket from branch name (e.g., tharding/report-1284/evidence-domain/v1 -> report-1284)
    set -l ticket (echo $branch | string match --regex '[a-zA-Z]+-[0-9]+' | string upper)

    if test -z "$ticket"
        echo "Could not extract ticket number from branch: $branch" >&2
        return 1
    end

    echo "[**[$ticket]**](https://taserintl.atlassian.net/browse/$ticket)"
end
