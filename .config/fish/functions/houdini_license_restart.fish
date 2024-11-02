function houdini_license_restart
    # Note:
    # To prevent license issues due to computer name changing when switching networks:
    # sudo scutil --set HostName yourmachinename
    # sudo scutil --set LocalHostName yourmachinename
    sudo launchctl unload /Library/LaunchDaemons/com.sidefx.sesinetd.plist
    sudo launchctl load -w /Library/LaunchDaemons/com.sidefx.sesinetd.plist
end
