#!/bin/bash
# author: gfw-breaker

langs="zh-CN"

index=README.md

## README page
cat > $index << EOF
### 江峰时刻《历史上的今天》节目字幕

---

| 视频节目名称 | 下载 | 下载 |
|---|---|---|
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
			awk 'NR%4==3' $srt > $txt
			echo "| $desc | [字幕文件]($srt?raw=true) | [纯文本]($txt?raw=true) |" >> $index
		done < $readme
	done
done

## commit
git add *
git commit -m "ok"
git push


