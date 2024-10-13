#!/usr/bin/fish --no-config

set grimfile ~/screenshots/$(date +'%s_grim.png')

slurp | 
    grim -g - $grimfile
