function __load_local --on-variable PWD --description "Load .local.fish on directory change"
    not status --is-command-substitution
    and test -e ".local.fish"
    and source ".local.fish"
end
