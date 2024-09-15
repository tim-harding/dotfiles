switch (uname)
case Linux
    xdg-mime default firefox.desktop application/pdf
    xdg-mime default firefox.desktop x-scheme-handler/https x-scheme-handler/http
    set --export BROWSER firefox
    set --export MOZ_ENABLE_WAYLAND 1
    set --export MOZ_WEBRENDER 1
end
