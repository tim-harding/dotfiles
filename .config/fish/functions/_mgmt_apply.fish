function _mgmt_apply -a topic
    set -l plus (mgmt diff $topic --plus)
    for program in $plus
        read --prompt-str "Profile for $program: " -l profile
        if test -z $profile
            continue
        end
        echo $program >> ~/.config/mgmt/$topic-$profile.conf
    end
    mgmt add $topic $plus

    set -l minus (mgmt diff $topic --minus)
    for program in $minus
        for file in ~/.config/mgmt/$topic-$FISH_PROFILE.conf
            cat $file | string match --invert $program > $file
        end
    end
    mgmt sub $topic $minus
end
