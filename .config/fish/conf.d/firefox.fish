switch (uname)
case Linux
    set --export BROWSER firefox
    set --export MOZ_ENABLE_WAYLAND 1
    set --export MOZ_WEBRENDER 1
    xdg-mime default firefox.desktop application/pdf x-scheme-handler/https x-scheme-handler/http
end
