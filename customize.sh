SKIPUNZIP=0

CONFIG="/data/adb/volsteps_config"
SETTINGS="/data/adb/volsteps_settings"

if [ -f "$CONFIG" ]; then
    STEPS=$(cat "$CONFIG" 2>/dev/null)
    if [ -n "$STEPS" ] && [ "$STEPS" -gt 0 ] 2>/dev/null; then
        echo "ro.config.media_vol_steps=$STEPS" > "$MODPATH/system.prop"

        if [ -f "$SETTINGS" ]; then
            STREAM=$(grep '^stream=' "$SETTINGS" | cut -d= -f2)
            if [ "$STREAM" = "both" ]; then
                echo "ro.config.vc_call_vol_steps=$STEPS" >> "$MODPATH/system.prop"
            fi
        fi

        ui_print "- Volume steps set to $STEPS"
    fi
else
    ui_print "- Volume steps set to 30 (default)"
    echo "30" > "$CONFIG"
fi
