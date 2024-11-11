function hyprland_events
    set -l active_window_id
    set -l socket "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
    socat - $socket | while read line
        set -l parts (string split '>>' $line)
        set -l event_name $parts[1]
        set -l args (string split , $parts[2])
        switch $event_name
            case activewindowv2
                set active_window_id $args
            case '*'
                echo "Unhandled event: " $event_name (string join ', ' $args)
        end
    end
end
