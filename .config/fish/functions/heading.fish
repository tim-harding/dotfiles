function heading
    set -l text $argv
    set -l text_length (string length $text)
    set -l padding 2
    set -l box_width (math $text_length + $padding \* 2)
    
    set_color --bold blue
    echo
    # Top border
    echo "╭"(string repeat -n $box_width "─")"╮"
    # Text with side borders
    echo "│"(string repeat -n $padding " ")"$text"(string repeat -n $padding " ")"│"
    # Bottom border
    echo "╰"(string repeat -n $box_width "─")"╯"
    set_color normal
end

# todo maybe a command called mug that's like gum but for fish (and really basic)