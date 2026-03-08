#!/usr/bin/env python3

# Watch keyboard layout changes and notify i3blocks
# Uses XKB extension via libX11 (ctypes) to receive events
# Dependencies: libX11.so.6 (libx11-6), xkblayout-state

import ctypes, select, subprocess
from ctypes import byref, c_int, c_uint, c_ulong, c_void_p, create_string_buffer

X = ctypes.CDLL("libX11.so.6")

# must be set or pointer is truncated on 64-bit
X.XOpenDisplay.restype = c_void_p

dpy = X.XOpenDisplay(None)

# Query the XKB extension to get its event base
# (all XKB events share one X event type)
ev_base, err, op, major, minor = (c_int() for _ in range(5))
major.value = 1
X.XkbQueryExtension(
    dpy, byref(op), byref(ev_base), byref(err), byref(major), byref(minor)
)

# Register for XKB state events (0x1=NewKeyboardNotify, 0x2=StateNotify)
X.XkbSelectEvents(dpy, c_uint(0x0100), c_ulong(0x3), c_ulong(0x3))
# Specify which state details to deliver (0x3FFF = all); required or no events arrive
X.XkbSelectEventDetails(
    dpy, c_uint(0x0100), c_uint(2), c_ulong(0x3FFF), c_ulong(0x3FFF)
)
X.XFlush(dpy)  # send buffered requests to the X server before blocking on select()

fd = X.XConnectionNumber(dpy)  # file descriptor for the X connection
buf = create_string_buffer(192)  # buffer large enough for any XEvent

last = None
while True:
    select.select([fd], [], [])
    while X.XPending(dpy):
        X.XNextEvent(dpy, buf)
        cur = subprocess.run(
            ["xkblayout-state", "print", "%s"], capture_output=True, text=True
        ).stdout.strip()
        if cur != last:
            last = cur
            subprocess.run(["pkill", "-SIGRTMIN+11", "i3blocks"])
