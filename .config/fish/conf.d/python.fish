set -xg PYTHONPATH
switch $platform
    case Linux
        last /usr/share/blender/*/scripts/modules/ | read -l PYTHONPATH_BLENDER
        if not contains -- $PYTHONPATH_BLENDER $PYTHONPATH
            set --append PYTHONPATH $PYTHONPATH_BLENDER
        end

        last /opt/hfs*/houdini/python*libs | read -l PYTHONPATH_HOUDINI
        if not contains -- $PYTHONPATH_HOUDINI $PYTHONPATH
            set --append PYTHONPATH $PYTHONPATH_HOUDINI
        end
end
