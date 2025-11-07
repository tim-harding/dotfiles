function repo
    set -l base ~/code
    set -l repo
    
    # Parse arguments
    argparse h/here -- $argv
    or return
    
    # Check for --here or -h flag
    if set -q _flag_here
        # Use current repo
        set -l current_path (pwd)
        if string match -q "$base/*" $current_path
            set repo (string replace "$base/" '' $current_path | cut -d/ -f1)
        else
            echo "Not currently in a repo under $base"
            return 1
        end
    else
        # Step 1: Choose repo
        path basename $base/* | fzf --select-1 --query $argv | read -l repo
        or return
    end
    
    # Step 2: Find the main git directory (check common names first, then use find)
    set -l repo_path $base/$repo
    set -l git_dir
    
    for dir in main master trunk
        if test -d $repo_path/$dir/.git
            set git_dir $repo_path/$dir
            break
        end
    end
    
    if test -z "$git_dir"
        set git_dir (find $repo_path -name .git -type d -print -quit | string replace '/.git' '')
    end
    
    if test -z "$git_dir"
        echo "Could not find git directory in $repo_path"
        return 1
    end
    
    # Step 3: Get all branch dates at once (fast), then match with worktrees
    set -l branch_dates (git -C $git_dir for-each-ref --format='%(refname:short) %(committerdate:unix)' refs/heads/)
    
    git -C $git_dir worktree list --porcelain | \
        awk -v branch_dates="$branch_dates" '
            BEGIN {
                split(branch_dates, bd_array, "\n")
                for (i in bd_array) {
                    split(bd_array[i], parts, " ")
                    dates[parts[1]] = parts[2]
                }
            }
            /^worktree / {path=$2} 
            /^branch / {
                branch=$2
                sub("refs/heads/", "", branch)
                commit_date = dates[branch] ? dates[branch] : 0
                print commit_date "\t" path "\t" branch
            }
        ' | \
        sort -rn | cut -f2,3 | string replace "$repo_path/" '' | fzf --select-1 --with-nth=2 --delimiter='\t' | cut -f1 | read -l selected
    and cd $repo_path/$selected
end
