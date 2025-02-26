set -xg PYTHONPATH
switch $platform
    case Linux
        # Separate globbing to avoid warning when not present
        set -l blender /usr/share/blender/*/scripts/modules/
        last $blender | read -l PYTHONPATH_BLENDER
        if not contains -- $PYTHONPATH_BLENDER $PYTHONPATH
            set --append PYTHONPATH $PYTHONPATH_BLENDER
        end

        set -l houdini /opt/hfs*/houdini/python*libs
        last $houdini | read -l PYTHONPATH_HOUDINI
        if not contains -- $PYTHONPATH_HOUDINI $PYTHONPATH
            set --append PYTHONPATH $PYTHONPATH_HOUDINI
        end
end
