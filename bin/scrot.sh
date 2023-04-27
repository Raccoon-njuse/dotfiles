#!/bin/bash
#scrot截图 实现:
# 1. scr 默认全屏截图，名称为日期，存储路径默认 pic/scr
# 2. scr name 默认全屏截图，名称为name，存储路径默认 pic/scr
# 3. scr -s 选区截图，名称日期，路径scr
# 4. scr -s name 选区截图，名称日期，路径scr
# 5. 如果自定路径 则运行原生命令即可 scrot -s ~/path/aa.png 或者 到需要的目录，scrot, scrot -s， scrot aa, scrot -s aa
if [[ $1 == '' ]]; then
  scrot ~/Pictures/scrot/%Y-%m-%d_%H:%M:%S.png 
elif [[ $1 == '-clip' ]]; then
  filename=$(date +'/tmp/Screenshot_%Y%m%d%H%M%S.png')
  echo $filename
  scrot -s $filename && xclip -selection clipboard -t image/png -i $filename
elif [[ $1 == '-s' ]]; then
  if [[ $2 == '' ]]; then
    scrot -s ~/Pictures/scrot/%Y-%m-%d_%H:%M:%S.png
  else
    scrot -s ~/Pictures/scrot/$2.png
  fi
else
  scrot ~/Pictures/scrot/$1.png
fi

