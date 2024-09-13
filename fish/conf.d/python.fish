set --erase --global PYTHONPATH

path_latest /usr/share/blender/*/scripts/modules/ | read PYTHONPATH_BLENDER 
if not contains -- $PYTHONPATH_BLENDER $PYTHONPATH
    set --export --global --append PYTHONPATH $PYTHONPATH_BLENDER
end

path_latest /opt/hfs*/houdini/python*libs | read PYTHONPATH_HOUDINI
if not contains -- $PYTHONPATH_HOUDINI $PYTHONPATH
    set --export --global --append PYTHONPATH $PYTHONPATH_HOUDINI
end


