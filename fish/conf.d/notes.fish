function notes_git_sync
    date
    echo "notes_git_sync start"

    realpath ~/notes | read notes_dir
    cd $notes_dir

    set is_dirty 0
    fswatch \
    --recursive \
    --batch-marker \
    --event "Created" \
    --event "Removed" \
    --event "Updated" \
    $notes_dir | while read f
        if test $f = "NoOp"; and test $is_dirty = 1
            date
            git commit -m.
            git push
            set is_dirty 0
        else if string match --regex ".*\\.norg\$" $f > /dev/null
            string replace "$notes_dir/" "" "$f" | read local
            set is_dirty 1
            git add $local
        end
    end
end

function notes_git_sync_install
    switch (uname)
    case Darwin
        # Helpful resource:
        # https://gist.github.com/masklinn/a532dfe55bdeab3d60ab8e46ccc38a68
        id | string match --regex --groups-only "uid=(\\d+)" | read uid
        set service_name local.notes_git_sync
        set domain_target "gui/$uid"
        set service_target "$domain_target/$service_name"
        set agent_dir ~/Library/LaunchAgents
        set plist "$service_name.plist"
        cp "~/.config/misc/$plist" $agent_dir
        launchctl bootout $service_target
        launchctl bootstrap $domain_target "$agent_dir/$plist"
    end
end
