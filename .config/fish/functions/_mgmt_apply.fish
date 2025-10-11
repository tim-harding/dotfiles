function _mgmt_apply -a topic
    switch $topic
        case all
            for topic in (mgmt topics)
                _mgmt_apply $topic
            end
            return
    end

    set -l plus (mgmt diff $topic --plus)
    for program in $plus
        read --prompt-str "Profile for $program: " -l profile
        if test -z $profile
            continue
        end
        echo $program >> ~/.config/mgmt/$topic-$profile.conf
    end
    mgmt add $topic $plus

    # set -l minus (mgmt diff $topic --minus)
    # for program in $minus
    #     read --prompt-str "Remove $program? [y/N] " -l response
    #     if string match -qi 'y' -- $response
    #         for file in ~/.config/mgmt/$topic-$FISH_PROFILE.conf
    #             cat $file | string match --invert $program > $file
    #         end
    #     end
    # end
    # mgmt sub $topic $minus
end
