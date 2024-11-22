function caffeine
    sudo pmset -a disablesleep 1
    read --prompt-str 'Press enter to stop'
    sudo pmset -a disablesleep 0
end
