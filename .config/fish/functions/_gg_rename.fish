function _gg_rename --argument-names new_name -d 'Rename branch and move worktree directory'
    set -l old_name (git branch --show-current)
    if test -z "$old_name"
        echo "Not on a branch" >&2
        return 1
    end

    if test -z "$new_name"
        read -P "Rename '$old_name' to: " new_name
        or return
    end

    if test -z "$new_name"
        echo "No new name provided" >&2
        return 1
    end

    set -l old_dir (pwd)

    # Find worktree root by getting the main worktree's parent directory
    set -l main_worktree (git worktree list --porcelain | grep '^worktree ' | head -1 | cut -d' ' -f2-)
    set -l worktree_root (path dirname $main_worktree)
    set -l new_dir (path normalize $worktree_root/$new_name)

    if test -d "$new_dir"
        echo "Directory $new_dir already exists" >&2
        return 1
    end

    # Move the worktree directory
    git worktree move "$old_dir" "$new_dir"
    or return

    # Rename the branch
    git branch -m "$old_name" "$new_name"
    or begin
        # Rollback worktree move if branch rename fails
        git worktree move "$new_dir" "$old_dir"
        return 1
    end

    cd "$new_dir"
end

