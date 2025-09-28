function _mgmt_uv_ls -d 'List tools installed by uv'
    if not command -q uv
        echo 'uv not found' >&2
        return 127
    end

    uv tool list
end