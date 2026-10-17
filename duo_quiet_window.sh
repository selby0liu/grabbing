#!/bin/zsh
# 10/16 抢购静默窗口：22:00 关掉监控 App，23:30 再打开
# 目的是开售那半小时内，这个 App 不去连服务器、不发任何通知，
# 免得它的弹窗和声音打断你下单。
MODE="$1"
APP="/Users/liujingcheng/Desktop/开发/苹果库存监控-柳景盛开发.app"
LOG="$HOME/Library/Application Support/iPhoneDuoMonitor/logs/quiet_window.log"
say() { echo "$(date '+%Y-%m-%d %H:%M:%S') [$MODE] $*" >> "$LOG"; }

# 安全闸：只在 2026-10-16 当天生效。launchd 的日历触发不支持指定年份，
# 不加这道判断的话，以后每年 10 月 16 日都会莫名其妙关掉你的 App。
TODAY=$(date '+%Y-%m-%d')
if [ "$TODAY" != "2026-10-16" ]; then
  say "今天是 $TODAY，不是 2026-10-16，什么都不做"
  exit 0
fi

case "$MODE" in
  off)
    say "开售前 30 分钟，关闭监控 App"
    osascript -e 'tell application "iPhoneDuoMonitor" to quit' 2>/dev/null
    sleep 3
    pgrep -f "iPhoneDuoMonitor" >/dev/null 2>&1 && { pkill -f "iPhoneDuoMonitor"; sleep 2; }
    pgrep -f "iPhoneDuoMonitor" >/dev/null 2>&1 && pkill -9 -f "iPhoneDuoMonitor"
    pkill -x afplay 2>/dev/null
    say "剩余进程 $(pgrep -f iPhoneDuoMonitor | wc -l | tr -d ' ') 个"
    ;;
  on)
    say "开售一小时后，重新打开监控 App"
    open "$APP"
    sleep 10
    say "进程 $(pgrep -f iPhoneDuoMonitor | wc -l | tr -d ' ') 个"
    # 任务完成，把两个定时器卸掉并删除，不留残余
    for n in off on; do
      launchctl unload "$HOME/Library/LaunchAgents/com.duomonitor.quiet.$n.plist" 2>/dev/null
      rm -f "$HOME/Library/LaunchAgents/com.duomonitor.quiet.$n.plist"
    done
    say "定时器已自行清理完毕"
    ;;
  *)
    say "未知模式"; exit 1 ;;
esac
