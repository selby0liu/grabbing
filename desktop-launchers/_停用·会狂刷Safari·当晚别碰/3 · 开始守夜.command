#!/bin/zsh
cd "/Users/liujingcheng/Dev/projects/iphone-duo-monitor/iphone-duo-monitor" || exit 1
clear
if pgrep -f "launch_watch.py" > /dev/null 2>&1; then
  echo "！已经有一个守夜进程在跑了。"
  echo "  想重开就先双击「9 · 紧急停止」。"
  echo; echo "按回车关闭。"; read; exit 1
fi
echo "======================================"
echo "  开售守夜"
echo "======================================"
echo
echo "  脚本只管右半屏那三个标签页。"
echo "  左半屏的首页完全归你，脚本不碰，也不移动任何窗口。"
echo
echo "  19:58 之前每分钟刷一次待命，到点自动转全速。"
echo "  标签页网址被跳走了会自动拉回来。"
echo
echo "  停止：Ctrl+C／关窗口／双击「9 · 紧急停止」"
echo "  响铃时按回车静音，脚本继续跑。"
echo
/usr/bin/python3 -u launch_watch.py --start 19:58
echo
echo "--------------------------------------"
echo "已停止。Safari 窗口都留着，你可以手动接着刷。按回车关闭。"
read
