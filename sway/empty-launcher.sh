#!/bin/bash
state_file="/tmp/sway-empty-launcher.lock"

swaymsg -m -t subscribe '["workspace"]' 2>/dev/null | while read -r line; do
    case "$line" in
        '{ "change": "focus'*|'{ "change": "focus'*)
            if [ ! -f "$state_file" ]; then
                empty=$(swaymsg -t get_tree \
                  | jq '[.. | select(.type? == "workspace")
                         | select([.. | select(.focused? == true)] | length > 0)
                         | .nodes[], .floating_nodes[]] | length')
                if [ "$empty" -eq 0 ]; then
                    touch "$state_file"
                    fuzzel < /dev/null
                    rm -f "$state_file"
                fi
            fi
            ;;
    esac
done
