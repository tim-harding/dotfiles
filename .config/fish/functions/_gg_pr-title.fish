function _gg_pr-title -d 'Generate PR title prefix from branch name' --argument-names type
    set -l branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if test $status -ne 0
        echo "Not in a git repository" >&2
        return 1
    end

    # Extract ticket from branch name (e.g., tharding/report-1269/v1 -> report-1269)
    set -l ticket (echo $branch | string match --regex '[a-zA-Z]+-[0-9]+' | string upper)

    # Check for no-jira as a special case
    if test -z "$ticket"
        set ticket (echo $branch | string match --regex 'no-jira')
    end

    if test -z "$ticket"
        echo "Could not extract ticket number from branch: $branch" >&2
        return 1
    end

    # Default to feat if no type specified
    if test -z "$type"
        set type feat
    end

    echo "$type($ticket): "
end
