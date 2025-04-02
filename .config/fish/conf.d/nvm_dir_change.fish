# Based on venv script
function __auto_source_nvm --on-variable PWD --description "Activate nvm on directory change"
    status --is-command-substitution; and return

    if git rev-parse --show-toplevel &>/dev/null
        set gitdir (realpath (git rev-parse --show-toplevel))
        set cwd (pwd -P)
        while string match "$gitdir*" "$cwd" &>/dev/null
            if test -e "$cwd/.nvmrc"
                nvm use &>/dev/null
                return
            else
                set cwd (path dirname "$cwd")
            end
        end
    end
end

__auto_source_nvm
