function _mgmt_diff -a topic
    set -e argv[1]
    argparse -x p,m 'p/plus' 'm/minus' -- $argv
    or return 1

    switch $topic
        case all
            for topic in (mgmt topics)
                heading $topic
                _mgmt_diff $topic $_flag_plus $_flag_minus
            end
            return
    end

    if test -z $topic
        echo 'Topic is required' >&2
        return 1
    elif not mgmt topics --contains $topic
        echo 'Topic not found' >&2
        return 1
    end

    set -l char (
        if set -q _flag_plus
            echo -n '\\+'
        else if set -q _flag_minus
            echo -n '\\-'
        else
            echo -n ' ' # Unchanged
        end
    )

    diff --unified \
    (mgmt list $topic | sort | psub) \
    (mgmt meow $topic | psub) \
    | string match --regex --invert '\-\-\-|\+\+\+|@@' \
    | string match --regex --groups-only "^$char(.*)\$"
end
