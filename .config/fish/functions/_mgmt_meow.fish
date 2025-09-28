function _mgmt_meow -a topic
    set -l candidates ~/.config/mgmt/$topic-$FISH_PROFILE.conf
    for candidate in $candidates
        test -f $candidate
        and cat $candidate | string match --regex '^[^#]+$'
    end
end
