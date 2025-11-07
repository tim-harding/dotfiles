set tide_prompt_add_newline_before true
set tide_prompt_color_separator_same_color black

set tide_left_prompt_items \
    pwd \
    git \
    newline \
    character
set tide_prompt_icon_connection ' '
set tide_left_prompt_separator_diff_color ' '
set tide_left_prompt_separator_same_color ' '
# set tide_left_prompt_separator_diff_color 
# set tide_left_prompt_separator_same_color 

set tide_right_prompt_items \
    kubectl \
    status \
    cmd_duration \
    context \
    jobs \
    time
set tide_right_prompt_separator_diff_color ' '
set tide_right_prompt_separator_same_color ' '
# set tide_right_prompt_separator_diff_color 
# set tide_right_prompt_separator_same_color 

set tide_pwd_bg_color
set tide_pwd_color_dirs cyan
set tide_pwd_color_truncated_dirs $tide_pwd_color_dirs
set tide_pwd_color_anchors $tide_pwd_color_dirs

set tide_git_truncation_strategy l # truncate beginning, not end
set tide_git_truncation_length 0
