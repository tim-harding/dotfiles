function houdini
    switch $platform
        case Linux
            # Note to self:
            #
            # OpenGL and OpenCL seems to be working at this point, but Vulkan is still and
            # issue because it crashes when I try switching to the Mesa drivers. 
            #
            # Maybe the Git mesa drivers have fixes?

            # Set up Vulkan. Based on vk_pro script.
            set ICD_DIR "/usr/share/vulkan/icd.d"
            # radv/radeonsi/mesa (seems to crash)
            # set --export VK_DRIVER_FILES "$ICD_DIR/radeon_icd.i686.json" "$ICD_DIR/radeon_icd.x86_64.json"
            # amdgpu-pro (Vulkan could not be initialized)
            # set --export VK_DRIVER_FILES "$ICD_DIR/amd_pro_icd32.json" "$ICD_DIR/amd_pro_icd64.json"
            # amkvlk (Vulkan could not be initialized)
            # set --export VK_DRIVER_FILES "$ICD_DIR/amd_icd32.json" "$ICD_DIR/amd_icd64.json" 

            # Set up OpenGL. Based on progl script.
            set --export --append LD_LIBRARY_PATH /opt/amdgpu/lib/
            # set --export --append LD_LIBRARY_PATH "/usr/lib/amdgpu-pro/" # Using this slows down rendering

            # Set up OpenCL
            set --export DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1 1
            set --export RUSTICL_ENABLE radeonsi

            # Fix for Wayland
            set --export QT_QPA_PLATFORM xcb

            fish_add_path /home/tim/Documents/installs/cycles/install
            set --export PXR_PLUGINPATH_NAME /home/tim/Documents/installs/cycles/install/houdini/dso/usd_plugins
            set -l hfs_dir (last /opt/hfs*/)
            $hfs_dir/bin/hindie
    end
end
