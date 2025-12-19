function _mgmt_add -a topic
    set -e argv[1]
    switch $topic
        case cargo
            for crate in $argv
                cargo install $crate
            end
        case bun
            bun install --global $argv
        case npm
            npm install --global $argv
        case go
            go install $argv
        case cs
            cs install $argv
        case brew-formula
            brew install --formula $argv
        case brew-cask
            brew install --cask $argv
        case uv
            uv tool install $argv
        case nix
            nix profile add $argv
        case pacman
            sudo pacman -S $argv
        case aur
            yay -S $argv
        case *
            echo "Unknown topic: $topic" >&2
            return 1
    end
end
