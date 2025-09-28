function _mgmt_diff -a topic
    argparse -x p,m 'p/plus' 'm/minus' -- $argv
    or return 1

    if test -z $topic
        echo 'Topic is required' >&2
        return 1
    else if not mgmt topics --contains $topic
        echo 'Topic not found' >&2
        return 1
    end

    set -l char (
        if set -q _flag_plus
            echo -n '\\+'
        else if set -q _flag_minus
            echo -n '\\-'
        else
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
