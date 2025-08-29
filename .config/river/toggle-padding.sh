#!/bin/bash

STATE_FILE="$HOME/.config/river/padding_state"

VIEW_PADDING_DEFAULT=3
OUTER_PADDING_DEFAULT=6

if [ ! -f "$STATE_FILE" ]; then
    echo "default" > "$STATE_FILE"
fi

CURRENT_STATE=$(cat "$STATE_FILE")

pkill rivertile

if [ "$CURRENT_STATE" = "default" ]; then
    rivertile -view-padding 0 -outer-padding 0 &
    echo "zero" > "$STATE_FILE"
elif [ "$CURRENT_STATE" = "zero" ]; then
    rivertile -view-padding 8 -outer-padding 40 &
    echo "beuty" > "$STATE_FILE"
else
    rivertile -view-padding $VIEW_PADDING_DEFAULT -outer-padding $OUTER_PADDING_DEFAULT &
    echo "default" > "$STATE_FILE"
fi
