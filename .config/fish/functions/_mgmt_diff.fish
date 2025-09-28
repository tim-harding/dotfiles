function _mgmt_diff
    argparse 't/topic=' 'm/mode=' -- $argv
    or return 1

    if not set -q _flag_topic
        echo 'Topic is required' >&2
        return 1
    else if not mgmt topics --contains $_flag_topic
        echo 'Topic not found' >&2
        return 1
    end
    set -l topic $_flag_topic

    set -l mode same
    if set -q _flag_mode
        if contains $_flag_mode plus minus same
            set mode $_flag_mode
        else
            echo 'expected mode to be [plus|minus|same]' >&2
            return 1
        end
    end

    set -l char (
        switch $mode
            case plus
                echo -n '\\+'
            case minus
                echo -n '\\-'
            case same
                echo -n ' '
        end
    )

    set -l difference (
        diff --unified \
        (mgmt list $topic | psub) \
        (mgmt meow $topic | psub) \
        | string match --regex --invert '\-\-\-|\+\+\+|@@' \
        | string match --regex --groups-only "^$char(.*)\$"
    )
end
