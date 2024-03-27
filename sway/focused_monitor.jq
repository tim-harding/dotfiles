#!/usr/bin/jq -rf
.[] | 
select(.focused) | 
.name
