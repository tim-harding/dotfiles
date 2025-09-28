function ensure_installs
    # Todo: Also remove packages not listed
    # Todo: Include system packages

    # Determine config dir and active profiles
    set -l config_home $XDG_CONFIG_HOME
    if test -z "$config_home"
        set -l config_home ~/.config
    end
    set -l mgmt_dir $config_home/mgmt

    set -l profiles $FISH_PROFILE
    if test (count $profiles) -eq 0
        # Default to shared profile if none provided
        set -l profiles shared
    end

    if not command -q cargo
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    end

    switch $platform
        case Linux
            set -l binstall_url https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh
            curl -L --proto '=https' --tlsv1.2 -sSf $binstall_url | bash

        case Darwin
            # Brew taps
            set -l brew_taps
            for p in $profiles
                set -l taps_file $mgmt_dir/brew-tap-$p.conf
                if test -f $taps_file
                    for line in (cat $taps_file | string trim | string replace -r '\\s+#.*$' '' | string match -v -r '^\\s*$')
                        set brew_taps $brew_taps $line
                    end
                end
            end
            for tap in $brew_taps
                brew tap $tap
            end

            # Brew formulas
            set -l brew_formulas
            for p in $profiles
                set -l formulas_file $mgmt_dir/brew-formula-$p.conf
                if test -f $formulas_file
                    for line in (cat $formulas_file | string trim | string replace -r '\\s+#.*$' '' | string match -v -r '^\\s*$')
                        set brew_formulas $brew_formulas $line
                    end
                end
            end
            if test (count $brew_formulas) -gt 0
                brew install --formula $brew_formulas
            end

            # Brew casks
            set -l brew_casks
            for p in $profiles
                set -l casks_file $mgmt_dir/brew-cask-$p.conf
                if test -f $casks_file
                    for line in (cat $casks_file | string trim | string replace -r '\\s+#.*$' '' | string match -v -r '^\\s*$')
                        set brew_casks $brew_casks $line
                    end
                end
            end
            if test (count $brew_casks) -gt 0
                brew install --cask $brew_casks
            end
    end

    curl -LsSf https://astral.sh/uv/install.sh | sh
    uv tool install ruff@latest pyright@latest

    # Go binaries
    set -l go_pkgs
    for p in $profiles
        set -l go_file $mgmt_dir/go-$p.conf
        if test -f $go_file
            for line in (cat $go_file | string trim | string replace -r '\\s+#.*$' '' | string match -v -r '^\\s*$')
                set go_pkgs $go_pkgs $line
            end
        end
    end
    for pkg in $go_pkgs
        go install $pkg@latest
    end

    # bun global packages
    set -l bun_pkgs
    for p in $profiles
        set -l bun_file $mgmt_dir/bun-$p.conf
        if test -f $bun_file
            for line in (cat $bun_file | string trim | string replace -r '\\s+#.*$' '' | string match -v -r '^\\s*$')
                set bun_pkgs $bun_pkgs $line
            end
        end
    end
    if test (count $bun_pkgs) -gt 0
        bun install --global $bun_pkgs
    end

    # cargo binaries via cargo-binstall
    set -l cargo_bins
    for p in $profiles
        set -l cargo_file $mgmt_dir/cargo-$p.conf
        if test -f $cargo_file
            for line in (cat $cargo_file | string trim | string replace -r '\\s+#.*$' '' | string match -v -r '^\\s*$')
                set cargo_bins $cargo_bins $line
            end
        end
    end
    if test (count $cargo_bins) -gt 0
        cargo binstall $cargo_bins
    end

    # coursier installs
    set -l cs_tools
    for p in $profiles
        set -l cs_file $mgmt_dir/cs-$p.conf
        if test -f $cs_file
            for line in (cat $cs_file | string trim | string replace -r '\\s+#.*$' '' | string match -v -r '^\\s*$')
                set cs_tools $cs_tools $line
            end
        end
    end
    if test (count $cs_tools) -gt 0
        cs install $cs_tools
    end
end
