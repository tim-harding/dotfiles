function gg --argument-names cmd
    set --erase argv[1]

    switch $cmd
        case amend
            _gg_amend $argv
        case back
            _gg_back $argv
        case backup
            _gg_backup $argv
        case clone
            _gg_clone $argv
        case continue
            _gg_continue $argv
        case cull
            _gg_cull $argv
        case edit
            _gg_edit $argv
        case fixup
            _gg_fixup $argv
        case hard
            _gg_hard $argv
        case log
            _gg_log $argv
        case pick
            _gg_pick $argv
        case pr-desc
            _gg_pr-desc $argv
        case pr-title
            _gg_pr-title $argv
        case rebase
            _gg_rebase $argv
        case rename
            _gg_rename $argv
        case soft
            _gg_soft $argv
        case stash
            if test (count $argv) -gt 0 -a "$argv[1]" = untracked
                set --erase argv[1]
                _gg_stash_untracked $argv
            else
                _gg_stash $argv
            end
        case switch
            _gg_switch $argv
        case trunk
            _gg_trunk $argv
        case undo
            _gg_undo $argv
        case update
            _gg_update $argv
        case worktree
            if test (count $argv) -gt 0
                switch $argv[1]
                    case dir
                        set --erase argv[1]
                        _gg_worktree_dir $argv
                    case root
                        set --erase argv[1]
                        _gg_worktree_root $argv
                    case '*'
                        _gg_worktree $argv
                end
            else
                _gg_worktree $argv
            end
        case '*'
            echo $cmd not found >&2
            return 1
    end
end
