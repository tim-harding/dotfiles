function gh-bulk-pr --description "Bulk PR review/approve via gh"
    # Flags:
    #   -a/--author  GitHub author
    #   -r/--repo    owner/repo
    #   -s/--search  search term
    #   -m/--mode    review|approve (default: review)
    #   -n/--dry-run print actions only

    argparse h/help 'a/author=' 'r/repo=' 's/search=' 'm/mode=' n/dry-run -- $argv
    or begin
        echo "Usage: gh-bulk-pr [-a AUTHOR] [-r OWNER/REPO] [-s TERM] [-m review|approve] [-l N] [-H HOST] [-n]"
        return 2
    end

    set -l mode review
    test -n "$_flag_mode"; and set mode $_flag_mode

    set -l limit 50
    test -n "$_flag_limit"; and set limit $_flag_limit

    # Build gh list args
    set -l list_args pr list --json url
    test -n "$_flag_repo"; and set -a list_args -R $_flag_repo
    test -n "$_flag_author"; and set -a list_args --author $_flag_author
    test -n "$_flag_search"; and set -a list_args --search $_flag_search

    # Collect PR URLs
    set -l urls (gh $list_args | jq -r '.[].url')

    if test -z "$urls"
        echo "No PRs found."
        return 0
    end

    switch $mode
        case review
            for u in $urls
                if set -q _flag_dry_run
                    echo "Would diff $u"
                else
                    env PAGER=cat gh pr diff --color=always $u
                end
            end
        case approve
            for u in $urls
                if set -q _flag_dry_run
                    echo "Would approve $u"
                else
                    gh pr review $u --approve
                end
            end
        case '*'
            echo "Unknown mode: $mode (use 'review' or 'approve')."
            return 1
    end
end
