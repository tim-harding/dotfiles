function init_local_profile
    set -q is_initialized_local_profile
    and return

    set -q LOCAL_PROFILE
    or return

    set -l init_function (echo -s init_ $LOCAL_PROFILE _profile)
    $init_function

    set -g is_initialized_local_profile 1
end
