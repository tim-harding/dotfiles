#!/usr/bin/jq -rf
.[] | 
select(.name == "DP-2") | 
.transform
