function _gg_backup -d 'Make a backup of the current branch'
    set -l branch (git branch --show-current)
    set -l backup_prefix (echo -s $branch '-backup-*')
    set -l backups (git branch --list $backup_prefix)
    set -l version_number (math (count $backups) + 1)
    set -l new_branch (echo -s $branch '-backup-' $version_number)
    git branch $new_branch
    echo Created $new_branch
end
