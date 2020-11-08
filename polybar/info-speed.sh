#!/bin/bash

INTERVAL=2
SHOW_PING="no";
PING_HOST=1.1.1.1
INTERFACES=(enp3s0 wlp1s0)

SCN="/sys/class/net";

now() { date +%s.%N; }
calc() { echo $* | bc -l 2>/dev/null; }

last_bytes_rx=0;
last_bytes_tx=0;
last_update_ts=`now`;

get_bytes() {
    local rx_total=0;
    local tx_total=0;
    for iface in "${INTERFACES[@]}"; do
        if [[ -d "$SCN/$iface" ]]; then
            rx_cur=$(cat "$SCN/$iface/statistics/rx_bytes");
            tx_cur=$(cat "$SCN/$iface/statistics/tx_bytes");
            rx_total=$(($rx_total + $rx_cur));
            tx_total=$(($tx_total + $tx_cur));
        fi;
    done;
    echo "$rx_total $tx_total $(now)";
}

humanize() {
    sizes=(" B" "KB" "MB" "GB");
    count=$(echo "$1 / 1" | bc);
    if [[ "$count" -eq 0 ]]; then echo "   0_0  B"; return; fi
    i=$(echo $(calc "l($count) / l(1024)") / 1 | bc);
    # if [[ "$i" -eq 0 ]]; then i=1; fi
    size="${sizes[$i]}";
    scaled=$(printf "%6.1f" $(calc "$count / (1024 ^ $i)"));
    echo "$scaled ${size}";
}

ping_str="|N/A ms";
[[ "$SHOW_PING" == "yes" ]] || ping_str="";
echo "[  WAIT KB/s|  FUCK KB/s$ping_str]";
read last_bytes_rx last_bytes_tx last_update_ts <<<"$(get_bytes)";
while true; do
    if [[ "$SHOW_PING" == "yes" ]]; then
        if ! ping=$(ping -n -c 1 -W $INTERVAL $PING_HOST 2>/dev/null); then
            rtt_str="INF ms%{F-}";
        else
            rtt=$(echo "$ping" \
                  | sed -rn 's/.*time=([0-9]{1,})\.?[0-9]{0,} ms.*/\1/p');
            if [ "$rtt" -lt 50 ]; then
                color="";
            elif [ "$rtt" -lt 100 ]; then
                color="";
            elif [ "$rtt" -lt 150 ]; then
                color="";
            else
                color="";
            fi;
            rtt_str=$(printf "%s%3d ms" $color $rtt);
        fi;
    fi
    
    sleep_more=$(calc "$INTERVAL - ($(now) - $last_update_ts)");
    [ "$(echo "$sleep_more > 0" | bc)" -eq 1 ] && sleep $sleep_more;

    read bytes_rx bytes_tx update_ts <<<"$(get_bytes)";

    delta_ts=$(calc "$update_ts - $last_update_ts");
    speed_rx=$(calc "($bytes_rx - $last_bytes_rx) / $delta_ts");
    speed_tx=$(calc "($bytes_tx - $last_bytes_tx) / $delta_ts");
    
    hrx="$(humanize $speed_rx)/s";
    htx="$(humanize $speed_tx)/s";

    ping_str="|$rtt_str";
    [[ "$SHOW_PING" == "yes" ]] || ping_str="";
    echo "[$htx|$hrx$ping_str]";

    last_bytes_rx=$bytes_rx;
    last_bytes_tx=$bytes_tx;
    last_update_ts=$update_ts;
done;
