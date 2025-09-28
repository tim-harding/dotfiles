function _mgmt_ls_bun -d 'List global packages installed by bun'
    if not command -q bun
        echo 'bun not found' >&2
        return 127
    end

    bun pm ls -g
end




