function _mgmt_list -a topic
    switch $topic
        case cargo
            cargo install --list | string match --regex --groups-only '^([^ ]+) .+:'
        case bun
            bun pm ls --global | string match --regex --groups-only ' (.+)\@[^\@]+$'
        case npm
            npm list --global | string match --regex --groups-only ' (.+)\@[^\@]+$'
        case go
            gup list | string match --regex --groups-only ': ([^\@]+)'
        case cs
            cs list
        case brew-formula
            brew list --installed-on-request --full-name --formula
        case brew-cask
            brew list --installed-on-request --full-name --cask
        case uv
            uv tool list | string match --regex --invert '^\- ' | string match --regex --groups-only '^([^ ]+) '
        case *
            echo "Unknown topic: $topic" >&2
            return 1
    end
end
