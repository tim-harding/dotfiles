function __gg_clone
    string match --regex --quiet '\/(?<name>[^\/]+)\.git' $argv
    git clone $argv
    mv $name trunk
    mkdir $name
    mv trunk $name
end
