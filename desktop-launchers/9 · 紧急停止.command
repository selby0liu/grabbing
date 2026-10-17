#!/bin/zsh
clear
echo "======================================"
echo "  紧急停止"
echo "======================================"
echo
N=$(pgrep -f "night_watch.py|launch_watch.py" | wc -l | tr -d ' ')
if [ "$N" = "0" ]; then
  echo "没有在跑的自动刷新进程。"
else
  echo "找到 $N 个自动刷新进程，正在停止……"
  pkill -f "night_watch.py|launch_watch.py"; sleep 1
  pkill -9 -f "night_watch.py|launch_watch.py" 2>/dev/null
  pkill -x afplay 2>/dev/null; sleep 0.5
  R=$(pgrep -f "night_watch.py|launch_watch.py" | wc -l | tr -d ' ')
  if [ "$R" = "0" ]; then echo "已全部停止，铃声也停了。"; else echo "还剩 $R 个没停掉，告诉 Claude。"; fi
fi
echo
echo "Safari 窗口和标签页都没动，你可以手动接着刷。按回车关闭。"
read
