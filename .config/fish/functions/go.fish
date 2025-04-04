if command -q go
    fish_add_path -g (go env GOPATH)/bin
end
