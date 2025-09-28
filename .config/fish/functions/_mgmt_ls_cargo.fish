function _mgmt_ls_cargo -d 'List installed cargo binaries'
    if not command -q cargo
        echo 'cargo not found' >&2
        return 127
    end

    cargo install --list | sed -n 's/^\([^ ]\+\) v.*/\1/p'
end




