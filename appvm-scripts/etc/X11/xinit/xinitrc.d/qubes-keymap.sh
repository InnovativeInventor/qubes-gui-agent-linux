#!/bin/sh

# This file may be also executed by qubes-change-keyboard-layout

QUBES_KEYMAP="$(/usr/bin/qubesdb-read /keyboard-layout)"
QUBES_USER_KEYMAP="$(cat "$HOME/.config/qubes-keyboard-layout.rc" 2> /dev/null)"

set_keyboard_layout() {
    KEYMAP="$1"
    # Default value
    if [ -z "$KEYMAP" ]; then
        KEYMAP=us+
    fi
    KEYMAP_LAYOUT="$(echo "$KEYMAP"+ | cut -f 1 -d +)"
    KEYMAP_VARIANT="$(echo "$KEYMAP"+ | cut -f 2 -d +)"
    if [ -n "$KEYMAP_VARIANT" ]; then
        KEYMAP_VARIANT="-variant $KEYMAP_VARIANT"
    fi
    setxkbmap "$KEYMAP_LAYOUT" "$KEYMAP_VARIANT"
}

if [ -n "$QUBES_KEYMAP" ]; then
    set_keyboard_layout "$QUBES_KEYMAP"
fi

if [ -n "$QUBES_USER_KEYMAP" ]; then
    set_keyboard_layout "$QUBES_USER_KEYMAP"
fi
