function _install_ls_coursier -d 'List apps installed by coursier'
    if not command -q cs
        echo 'cs not found' >&2
        return 127
    end

    cs list
end


