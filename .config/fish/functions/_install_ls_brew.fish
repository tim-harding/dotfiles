function _install_ls_brew -d 'List apps installed by Homebrew'
    if not command -q brew
        echo 'brew not found' >&2
        return 127
    end

    brew list --formula
    echo
    brew list --cask
end


