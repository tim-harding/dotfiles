#!/usr/bin/env -S fish --no-config

echo -ns (date +"%A" | string sub --length 2) \r
echo -ns (date +"%d") \r
echo -ns (date +"%B" | string sub --length 2) \r\r
echo -ns (date +"%H") \r
echo (date +"%M")
