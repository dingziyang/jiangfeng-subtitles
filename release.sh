#!/bin/bash
# author: gfw-breaker

langs="zh"

index=README.md

## README page
cat > $index << EOF
### 《江峰时刻》节目字幕/文字稿

---
##### 友情链接：[免翻墙看禁闻，包含大纪元、新唐人等](https://github.com/gfw-breaker/banned-news)

| 视频节目名称 | 视频/音频 | 简体字幕  | 简体文字稿 | 正體字幕 | 正體文字稿 |
|---|---|---|---|---|---|
EOF

## generate
for lang in $langs; do
	months=$(ls -r $lang)
	for month in $months; do
		dir="$lang/$month"
		readme="$dir/readme.txt"
		while read line; do
			vid=$(echo $line | cut -d'.' -f1)
			desc=$(echo $line | cut -d'.' -f2)
			id=$(echo $line | cut -d'.' -f3)
			srt="$dir/$vid.srt"
			txt="$dir/$vid.txt"
			srtTw="$dir/$vid.tw.srt"
			txtTw="$dir/$vid.tw.txt"
			cat $srt | grep -v ^$ | egrep -v ' --> [0-9]+:' | egrep -v ^[0-9]+$  > $txt
			opencc -c s2tw.json -i $srt -o $srtTw
			opencc -c s2tw.json -i $txt -o $txtTw
			echo "| $desc | [下载](https://y2mate.com/zh-cn/search/$id) | [下载]($srt?raw=true) | [下载]($txt?raw=true) | [下載]($srtTw?raw=true) | [下載]($txtTw?raw=true) |" >> $index
		done < $readme
	done
done

## commit
git add *
git commit -m "ok"
git push


