function _install_ls_brew -d 'List Homebrew items (formulae or casks)'
    if not command -q brew
        echo 'brew not found' >&2
        return 127
    end

    set -l kind $argv[1]

    switch $kind
        case formula formulae formulas
            brew list --formula
        case cask casks
            brew list --cask
        case ''
            echo 'Usage: install ls brew (formula|cask)' >&2
            return 2
        case '*'
            echo "Unknown kind: $kind. Use 'formula' or 'cask'." >&2
            return 2
    end
end
