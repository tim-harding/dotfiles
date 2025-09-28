function _mgmt_topics
    argparse 'c/contains=' -- $argv
    or return

    if set -q _flag_contains
        contains $_flag_contains (mgmt topics)
    else
        path basename --no-extension ~/.config/mgmt/* \
        | string match --regex --groups-only '(.*)-\w+' \
        | uniq
    end
end
