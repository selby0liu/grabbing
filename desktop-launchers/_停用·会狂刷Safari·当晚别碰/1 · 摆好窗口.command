#!/bin/zsh
cd "/Users/liujingcheng/Dev/projects/iphone-duo-monitor/iphone-duo-monitor" || exit 1
clear
echo "======================================"
echo "  摆好窗口（开售前先点这个）"
echo "======================================"
echo
echo "  还原成你自己摆好并记住的那套布局："
echo "      左    苹果官网首页   ← 救急入口，脚本不刷新它"
echo "      中    星光白 512GB   ← 归脚本，提示音 Glass"
echo "      右    夜空色 512GB   ← 归脚本，提示音 Submarine"
echo
echo "  有货的那一刻，那个窗口自动撑满全屏，你不用手动拖。"
echo
/usr/bin/python3 -u launch_watch.py --setup
echo
echo "--------------------------------------"
echo "接着点「2 · 自检」。按回车关闭。"
read
