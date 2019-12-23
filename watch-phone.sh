#!/system/bin/sh
# [[file:~/src/github/cuty/README.org::script-on-phone][script-on-phone]]
set
(
    toast() {
        am startservice --user 0 -n com.bhj.setclip/.PutClipService --es toast "$1"
    }

    cd /data/data/com.android.shell/
    mkdir -p var
    (
        flock -n 9 || exit 0
        sleep_secs=180 # 每次最多玩 3 分钟

        times=0
        while true; do
            top_window=$(dumpsys window | sed -n '
# {%sed-mode%}
/mFocusedWindow=/{s,.* \(.*\)},\1,; p}
# {%/sed-mode%}
'
                      )
            case "$top_window" in
                *weibo*)
                    toast "包昊军，不可以一直玩儿哦，去做 10 个深蹲！"
                    sh /system/bin/input keyevent HOME
                    sleep_secs=3
                    times=0
                    ;;
                *com.tencent.mm/*)
                    toast "包昊军，不可以一直玩儿哦，去做 10 个深蹲！"
                    sh /system/bin/input keyevent HOME
                    ;;
                *com.android.chrome/*)
                    toast "包昊军，不可以一直玩儿哦，去做 10 个深蹲！"
                    sh /system/bin/input keyevent HOME
                    sleep_secs=600
                    ;;
                *onmyoji*)
                    toast "包昊军，不可以一直玩儿哦，去做 10 个深蹲！"
                    sh /system/bin/input keyevent HOME
                    sleep_secs=600
                    ;;
                *)
                    if let "times++ > 10"; then
                        sleep_secs=180
                    else
                        echo times is $times
                    fi
                    ;;
            esac

            sleep $sleep_secs || true
        done
    ) 9> var/watch-my-window.lock
)
# script-on-phone ends here
