#!/usr/bin/env -S fish --no-config

date +"%A" | string sub --length 2 | read -l weekday
date +"%B" | string sub --length 2 | read -l month
date +"%d" | read -l day
date +"%H" | read -l hour
date +"%M" | read -l minute

echo -s $weekday \r $day \r $month \r\r $hour \r $minute
