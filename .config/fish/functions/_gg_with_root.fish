function _gg_with_root -d 'Run function from git root'
    set -l root (gg root)
    if [ $root = (pwd) ]
        $argv
    else
        cd $root
        $argv
        prevd
    end
end
