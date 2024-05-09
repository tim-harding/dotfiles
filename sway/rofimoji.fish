#!/usr/bin/fish --no-config

rofimoji \
    --skin-tone neutral \
    --max-recent 0 \
    --prompt "" \
    --action type copy \
    --files block_elements box_drawing nerd_font geometric_shapes latin-1_supplement enclosed_alphanumerics math arrows chess_symbols emojis ~/.config/sway/rofimoji-custom
    # TODO: rofimoji 6.3.0, remove rofi
    # --selector tofi
