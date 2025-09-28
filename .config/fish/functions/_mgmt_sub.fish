function _mgmt_sub -a topic
    switch $topic
        case cargo
            cargo uninstall $argv
        case bun
            bun uninstall --global $argv
        case npm
            npm uninstall --global $argv
        case go
            go uninstall $argv
        case cs
            cs uninstall $argv
        case brew-formula
            brew uninstall --formula $argv
        case brew-cask
            brew uninstall --cask $argv
        case uv
            uv tool uninstall $argv
        case *
            echo "Unknown topic: $topic" >&2
            return 1
    end
end
