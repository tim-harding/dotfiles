# Catppuccin Frappe colors for gum
# https://github.com/charmbracelet/gum

# Catppuccin Frappe palette
set -l ctp_rosewater "#f2d5cf"
set -l ctp_flamingo "#eebebe"
set -l ctp_pink "#f4b8e4"
set -l ctp_mauve "#ca9ee6"
set -l ctp_red "#e78284"
set -l ctp_maroon "#ea999c"
set -l ctp_peach "#ef9f76"
set -l ctp_yellow "#e5c890"
set -l ctp_green "#a6d189"
set -l ctp_teal "#81c8be"
set -l ctp_sky "#99d1db"
set -l ctp_sapphire "#85c1dc"
set -l ctp_blue "#8caaee"
set -l ctp_lavender "#babbf1"
set -l ctp_text "#c6d0f5"
set -l ctp_subtext1 "#b5bfe2"
set -l ctp_subtext0 "#a5adce"
set -l ctp_overlay2 "#949cbb"
set -l ctp_overlay1 "#838ba7"
set -l ctp_overlay0 "#737994"
set -l ctp_surface2 "#626880"
set -l ctp_surface1 "#51576d"
set -l ctp_surface0 "#414559"
set -l ctp_base "#303446"
set -l ctp_mantle "#292c3c"
set -l ctp_crust "#232634"

# General gum styling
set -xg GUM_FILTER_INDICATOR_FOREGROUND $ctp_mauve
set -xg GUM_FILTER_SELECTED_PREFIX_FOREGROUND $ctp_green
set -xg GUM_FILTER_UNSELECTED_PREFIX_FOREGROUND $ctp_overlay0
set -xg GUM_FILTER_HEADER_FOREGROUND $ctp_blue
set -xg GUM_FILTER_TEXT_FOREGROUND $ctp_text
set -xg GUM_FILTER_MATCH_FOREGROUND $ctp_peach
set -xg GUM_FILTER_PROMPT_FOREGROUND $ctp_mauve
set -xg GUM_FILTER_PLACEHOLDER_FOREGROUND $ctp_overlay0
set -xg GUM_FILTER_WIDTH 0 # Full width

# gum choose
set -xg GUM_CHOOSE_CURSOR_FOREGROUND $ctp_mauve
set -xg GUM_CHOOSE_HEADER_FOREGROUND $ctp_blue
set -xg GUM_CHOOSE_ITEM_FOREGROUND $ctp_text
set -xg GUM_CHOOSE_SELECTED_FOREGROUND $ctp_green
set -xg GUM_CHOOSE_UNSELECTED_PREFIX_FOREGROUND $ctp_overlay0

# gum confirm
set -xg GUM_CONFIRM_PROMPT_FOREGROUND $ctp_mauve
set -xg GUM_CONFIRM_SELECTED_FOREGROUND $ctp_green
set -xg GUM_CONFIRM_UNSELECTED_FOREGROUND $ctp_overlay0

# gum input
set -xg GUM_INPUT_CURSOR_FOREGROUND $ctp_rosewater
set -xg GUM_INPUT_HEADER_FOREGROUND $ctp_blue
set -xg GUM_INPUT_PLACEHOLDER_FOREGROUND $ctp_overlay0
set -xg GUM_INPUT_PROMPT_FOREGROUND $ctp_mauve
set -xg GUM_INPUT_WIDTH 0 # Full width

# gum write
set -xg GUM_WRITE_HEADER_FOREGROUND $ctp_blue
set -xg GUM_WRITE_PLACEHOLDER_FOREGROUND $ctp_overlay0
set -xg GUM_WRITE_PROMPT_FOREGROUND $ctp_mauve
set -xg GUM_WRITE_WIDTH 0 # Full width

# gum spin
set -xg GUM_SPIN_SPINNER_FOREGROUND $ctp_mauve
set -xg GUM_SPIN_TITLE_FOREGROUND $ctp_text

# gum style
set -xg GUM_STYLE_FOREGROUND $ctp_text
set -xg GUM_STYLE_BACKGROUND $ctp_base
set -xg GUM_STYLE_BORDER_FOREGROUND $ctp_surface2

# gum table
set -xg GUM_TABLE_BORDER_FOREGROUND $ctp_surface2
set -xg GUM_TABLE_HEADER_FOREGROUND $ctp_blue
set -xg GUM_TABLE_CELL_FOREGROUND $ctp_text
set -xg GUM_TABLE_SELECTED_FOREGROUND $ctp_green

# gum pager
set -xg GUM_PAGER_HELP_FOREGROUND $ctp_overlay0
