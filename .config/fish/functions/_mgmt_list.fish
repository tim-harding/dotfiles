function _mgmt_list -a topic
    switch $topic
        case cargo
            cargo install --list | string match --regex --groups-only '^([^ ]+) .+:'
        case bun
            bun pm ls --global | string match --regex --groups-only ' (.+)\@[^\@]+$' | ansi_remove
        case npm
            npm list --global | string match --regex --groups-only ' (.+)\@[^\@]+$' | ansi_remove
        case go
            gup list | string match --regex --groups-only ': ([^\@]+)'
        case cs
            cs list
        case brew-formula
            brew list --formula --full-name --installed-on-request
        case brew-cask
            brew list --cask --full-name 
        case uv
            uv tool list 2>/dev/null | string match --regex --invert '^\- ' | string match --regex --groups-only '^([^ ]+) '
        case nix
            nix profile list
        case *
            echo "Unknown topic: $topic" >&2
            return 1
    end
end
