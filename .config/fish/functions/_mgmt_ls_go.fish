function _mgmt_ls_go -d 'List installed Go binaries in GOPATH/bin'
    if not command -q go
        echo 'go not found' >&2
        return 127
    end

    if set -q GOPATH
        set -l bin_dir "$GOPATH/bin"
    else
        set -l bin_dir "$HOME/go/bin"
    end

    if test -d $bin_dir
        ls -1 $bin_dir
    else
        echo "$bin_dir not found" >&2
        return 1
    end
end




