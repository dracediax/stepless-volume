#!/system/bin/sh
# Load saved volume steps config and apply via system.prop
# This runs at post-fs-data stage — BEFORE AudioService initializes
MODDIR=${0%/*}
CONFIG="/data/adb/volsteps_config"
SETTINGS="/data/adb/volsteps_settings"
LOGFILE="$MODDIR/debug.log"

echo "=== Stepless Volume Boot ===" > "$LOGFILE"
echo "Date: $(date)" >> "$LOGFILE"

if [ -f "$CONFIG" ]; then
    STEPS=$(cat "$CONFIG" 2>/dev/null)
    if [ -n "$STEPS" ] && [ "$STEPS" -gt 0 ] 2>/dev/null; then
        echo "ro.config.media_vol_steps=$STEPS" > "$MODDIR/system.prop"

        if [ -f "$SETTINGS" ]; then
            STREAM=$(grep '^stream=' "$SETTINGS" | cut -d= -f2)
            if [ "$STREAM" = "both" ]; then
                echo "ro.config.vc_call_vol_steps=$STEPS" >> "$MODDIR/system.prop"
            fi
        fi

        echo "steps=$STEPS" >> "$LOGFILE"
        echo "stream=$STREAM" >> "$LOGFILE"
        echo "system.prop=$(cat "$MODDIR/system.prop")" >> "$LOGFILE"
    fi
else
    echo "no config found — using default" >> "$LOGFILE"
fi
