#!/bin/zsh
cd "/Users/liujingcheng/Dev/projects/iphone-duo-monitor/iphone-duo-monitor" || exit 1
clear
if pgrep -f "launch_watch.py" > /dev/null 2>&1; then
  echo "！已经有一个守夜进程在跑，先双击「9 · 紧急停止」。"
  echo; echo "按回车关闭。"; read; exit 1
fi
echo "======================================"
echo "  演示：全速刷 2 分钟，然后自动停"
echo "======================================"
echo
echo "  看右半屏那个窗口。星光白每轮都刷，"
echo "  夜空色隔 1 轮，配置页隔 2 轮。"
echo
/usr/bin/python3 -u launch_watch.py --max-minutes 2
echo
echo "--------------------------------------"
echo "演示结束。按回车关闭。"
read
