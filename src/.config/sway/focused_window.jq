#!/usr/bin/jq -rfj
.. | 
select(.type?) | 
select(.focused).rect | 
"\(.x),\(.y) \(.width)x\(.height)"
