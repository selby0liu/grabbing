#!/bin/zsh
cd "/Users/liujingcheng/Dev/projects/iphone-duo-monitor/iphone-duo-monitor" || exit 1
clear
echo "======================================"
echo "  记住我现在的摆法"
echo "======================================"
echo
echo "  先把三个窗口拖成你想要的样子，再点这个。"
echo "  位置、大小、前后层次都会记下来，"
echo "  以后点「1 · 摆好窗口」就还原成这个样子。"
echo
/usr/bin/python3 -u launch_watch.py --save-layout
echo
echo "--------------------------------------"
echo "按回车关闭。"
read
