function repo
    argparse h/here -- $argv
    or return

    set -l base ~/code
    set -l repo
    if set -q _flag_here
        # Use current repo - find the main git dir via git-common-dir
        set -l git_common_dir (git rev-parse --path-format=absolute --git-common-dir 2>/dev/null)
        if test -z "$git_common_dir"
            echo "Not in a git repository"
            return 1
        end

        # Get repo root (parent of the main worktree)
        set -l repo_path (dirname (dirname $git_common_dir))

        if not string match -q "$base/*" $repo_path
            echo "Not currently in a repo under $base"
            return 1
        end

        # Get relative path from base
        set repo (string replace "$base/" '' $repo_path)
    else
        # Select repo
        begin
            pushd $base
            string join \n -- */*/*
            popd
        end | fzf --select-1 --query=$argv | read repo
        or return
    end

    # Step 2: Find the main git directory
    set -l repo_path $base/$repo
    set -l git_dir
    for dir in main master trunk
        if test -d $repo_path/$dir/.git
            set git_dir $repo_path/$dir
            break
        end
    end

    if test -z "$git_dir"
        set git_dir (find "$repo_path" -name .git -type d | head -1 | string replace '/.git' '')
    end

    if test -z "$git_dir"
        echo "Could not find git directory in $repo_path"
        return 1
    end

    # Step 3: Get worktrees and their commit dates, sort by recency
    awk '
        NR == FNR {dates[$1] = $2; next}
        /^worktree / {path=$2}
        /^branch / {
            branch=$2
            sub("refs/heads/", "", branch)
            print (dates[branch] ? dates[branch] : 0) "\t" path "\t" branch
        }
    ' (git -C $git_dir for-each-ref --format='%(refname:short) %(committerdate:unix)' refs/heads/ | psub) \
        (git -C $git_dir worktree list --porcelain | psub) | sort -rn | cut -f2,3 | string replace "$repo_path/" '' | fzf --select-1 --with-nth=2 --delimiter='\t' | cut -f1 | read selected
    and cd $repo_path/$selected
end
