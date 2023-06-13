#!/bin/bash

# 定义一个数组来存储域名
domains=("gateway.icloud.com" "itunes.apple.com" "download-installer.cdn.mozilla.net" "addons.mozilla.org"
"www.microsoft.com" "www.lovelive-anime.jp" "swdist.apple.com" "swcdn.apple.com" "updates.cdn-apple.com"
"mensura.cdn-apple.com" "osxapps.itunes.apple.com" "aod.itunes.apple.com" "cdn-dynmedia-1.microsoft.com"
"update.microsoft" "software.download.prss.microsoft.com" "s0.awsstatic.com" "d1.awsstatic.com"
"images-na.ssl-images-amazon.com" "m.media-amazon.com" "player.live-video.net" "dl.google.com" "www.yahoo.com")

declare -A domain_pings

# ping每一个域名，并保存结果
for domain in "${domains[@]}"; do
    ping_result=$(ping -c 4 "$domain" | tail -1| awk '{print $4}' | cut -d '/' -f 2)
    domain_pings[$domain]=$ping_result
done

# 按照延迟从小到大排序
for domain in "${!domain_pings[@]}"; do
    echo $domain '-' ${domain_pings["$domain"]}
done | sort -n -t "-" -k 2
