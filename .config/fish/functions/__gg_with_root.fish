function __gg_with_root
    set -l root (gg root)
    if [ $root = (pwd) ]
        $argv
    else
        cd $root
        $argv
        prevd
    end
end
