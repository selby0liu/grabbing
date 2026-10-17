#!/bin/zsh
# 蹲守服务器连通性。每 5 秒采一次，只在「出问题」时记录，
# 同时记下当时的本地网络状态，好区分是「你的网断了」还是「服务器不行」。
LOG="$HOME/Library/Application Support/iPhoneDuoMonitor/logs/link_watch.log"
A=100.122.114.47
B=100.70.21.76
MAXHOURS=12
END=$(( $(date +%s) + MAXHOURS*3600 ))
ok=0; bad=0

echo "$(date '+%F %T') ===== 开始蹲守，最多 $MAXHOURS 小时 =====" >> "$LOG"
while [ "$(date +%s)" -lt "$END" ]; do
  ta=$(curl -sS --max-time 8 -o /dev/null -w '%{time_total}' "http://$A:8765/status" 2>/dev/null)
  tb=$(curl -sS --max-time 8 -o /dev/null -w '%{time_total}' "http://$B:8765/status" 2>/dev/null)
  if [ -n "$ta" ] && [ -n "$tb" ]; then
    ok=$((ok+1))
  else
    bad=$((bad+1))
    # 两台里有任何一台不通，就把现场状态全记下来
    net=$(ping -c 2 -t 3 1.1.1.1 2>/dev/null | tail -1 | sed 's/.*= //')
    ip=$(ifconfig en0 2>/dev/null | awk '/inet /{print $2}')
    rssi=$(system_profiler SPAirPortDataType 2>/dev/null | grep -m1 "Signal / Noise" | sed 's/.*: //')
    ts=$(/Applications/Tailscale.app/Contents/MacOS/Tailscale status 2>/dev/null | grep -cE "active|idle")
    echo "$(date '+%F %T') [失败] 阿里云=${ta:-X} 北京=${tb:-X} | 本机IP=$ip 公网=${net:-不通} 信号=$rssi Tailscale在线节点=$ts" >> "$LOG"
  fi
  # 每 100 次采样记一次汇总，方便看整体比例
  if [ $(( (ok+bad) % 100 )) -eq 0 ] && [ $((ok+bad)) -gt 0 ]; then
    echo "$(date '+%F %T') [汇总] 累计成功 $ok 次 / 失败 $bad 次" >> "$LOG"
  fi
  sleep 5
done
echo "$(date '+%F %T') ===== 蹲守结束 成功 $ok 失败 $bad =====" >> "$LOG"
