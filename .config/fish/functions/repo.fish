function repo
    set -l base ~/code
    
    # Step 1: Choose repo
    path basename $base/* | fzf --select-1 --query $argv | read -l repo
    or return
    
    # Step 2: Find any git directory (main repo has .git as directory, worktrees have .git as file)
    set -l repo_path $base/$repo
    set -l git_dir
    for path in $repo_path/**/.git
        if test -d $path
            set git_dir (dirname $path)
            break
        end
    end
    
    if test -z "$git_dir"
        echo "Could not find git directory in $repo_path"
        return 1
    end
    
    # Step 3: Get worktrees from git, sort by commit date
    git -C $git_dir worktree list --porcelain | \
        awk '
            /^worktree / {path=$2} 
            /^branch / {
                branch=$2
                sub("refs/heads/", "", branch)
                cmd = "git -C " path " log -1 --format=%ct " branch " 2>/dev/null || echo 0"
                cmd | getline commit_date
                close(cmd)
                print commit_date "\t" path "\t" branch
            }
        ' | \
        sort -rn | cut -f2,3 | string replace "$repo_path/" '' | fzf --select-1 --with-nth=2 --delimiter='\t' | cut -f1 | read -l selected
    and cd $repo_path/$selected
end
