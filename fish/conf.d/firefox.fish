set --export BROWSER firefox

switch (uname)
case Linux
    xdg-mime default firefox.desktop application/pdf
    set --export MOZ_ENABLE_WAYLAND 1
    set --export MOZ_WEBRENDER 1
end
