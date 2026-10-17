#!/bin/zsh
cd "/Users/liujingcheng/Dev/projects/iphone-duo-monitor/iphone-duo-monitor" || exit 1
clear
echo "======================================"
echo "  自检（只读页面，不刷新）"
echo "======================================"
echo
/usr/bin/python3 -u night_watch.py --selftest
echo
echo "按回车关闭。"
read
