#!/bin/bash
# author: gfw-breaker

langs="zh-CN"

index=README.md

## README page
cat > $index << EOF
### 江峰时刻《历史上的今天》节目字幕

---

| 视频节目名称 | 下载 | 下载 | 下载 | 下载 | 下载 |
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
			srt="$dir/$vid.srt"
			txt="$dir/$vid.txt"
			srtTw="$dir/$vid.tw.srt"
			txtTw="$dir/$vid.tw.txt"
			awk 'NR%4==3' $srt > $txt
			opencc -c s2tw.json -i $srt -o $srtTw
			opencc -c s2tw.json -i $txt -o $txtTw
			echo "| $desc | [简体字幕]($srt?raw=true) | [简体文字稿]($txt?raw=true) | [文字图](imgs/$vid.png?raw=true) | [正體字幕]($srtTw?raw=true) | [正體文字稿]($txtTw?raw=true) |" >> $index
		done < $readme
	done
done

## commit
git add *
git commit -m "ok"
git push


