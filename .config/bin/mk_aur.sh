#!/bin/zsh
all=34423
page=$[all/250+1]

echo -n > result.htm
for i in {0..$page}; do
    curl "https://aur.archlinux.org/packages.php?O=$[i*250]&PP=250" >> result.htm
done
cat result.htm | grep "'packages.php?ID" | sed -e "s/^.*<span class='black'>//g" -e "s/<\/.*$//g" > result.txt
