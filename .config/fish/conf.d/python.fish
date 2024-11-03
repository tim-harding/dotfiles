set --erase PYTHONPATH
switch $platform
    case Linux

        last /usr/share/blender/*/scripts/modules/ | read PYTHONPATH_BLENDER
        if not contains -- $PYTHONPATH_BLENDER $PYTHONPATH
            set --export --global --append PYTHONPATH $PYTHONPATH_BLENDER
        end

        last /opt/hfs*/houdini/python*libs | read PYTHONPATH_HOUDINI
        if not contains -- $PYTHONPATH_HOUDINI $PYTHONPATH
            set --export --global --append PYTHONPATH $PYTHONPATH_HOUDINI
        end

end
