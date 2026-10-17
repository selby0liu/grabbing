#!/bin/zsh
cd "/Users/liujingcheng/Dev/projects/iphone-duo-monitor/iphone-duo-monitor" || exit 1
clear
if pgrep -f "night_watch.py --rehearse" > /dev/null 2>&1; then
  echo "！已经有一个演练在跑了。先按那个窗口里的 Return 关掉它。"; echo; echo "按回车关闭。"; read; exit 1
fi
# 倒计时（「3 · 16号晚上自动刷新」）可以同时开着：演练只碰 iPhone 17 的页面，碰不到 512 白。
echo "======================================"
echo "  演练：把「刷到能买了」整套走一遍"
echo "======================================"
echo
echo "  用现在就能买的 iPhone 17 页面代替 Duo，代码和当晚完全一样。"
echo "  脚本会：开一个 iPhone 17 窗口 → 刷新 → 认出能买了"
echo "        → 撑满屏幕推到你面前 → 响铃（你一动鼠标铃就停）。"
echo "  误判了想让它接着刷 → 按 Control+C；关闭 → 按 Return。"
echo
echo "  512 白那个标签页不会被碰。"
echo "  演练时别真的去结账付款。"
echo
echo "按回车开始演练……"; read
/usr/bin/python3 -u night_watch.py --rehearse --fast-minutes 3 --slow-minutes 0
echo
echo "收尾：关掉演练用的 iPhone 17 窗口……"
osascript -e 'tell application "Safari"
repeat with w in windows
repeat with t in tabs of w
if (URL of t as string) contains "mg6x4ch" then close t
end repeat
end repeat
end tell' >/dev/null 2>&1
echo "演练结束。512 白的标签页还在原处。按回车关闭。"
read
