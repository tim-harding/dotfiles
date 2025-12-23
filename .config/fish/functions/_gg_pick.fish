function _gg_pick -d "Pick through changes since trunk"
    git log -p (git merge-base (gg trunk) @)
end
