#!/bin/sh

WORKSPACE=$1
WKSP=`xprop -root -notype  _NET_CURRENT_DESKTOP | sed 's#.* =##'`
CURRENT_WORKSPACE=`expr 1 + $WKSP`
if [ $CURRENT_WORKSPACE -ne $WORKSPACE ]; then
    scrot -q 50 PRTSRC.jpeg
    feh PRTSRC.jpeg&
    FEH_WINDOW=$!
    #WAIT (give i3 time to switch workspace in the background)
    sleep .2
fi
slide_FEH_LEFT(){
    LONG_LINE="move left 1px"
    for i in {1..11}; do
        LONG_LINE=$LONG_LINE","$LONG_LINE
    done
    i3-msg "[class=feh] $LONG_LINE"
}
slide_FEH_RIGHT(){
    LONG_LINE="move right 1px"
    for i in {1..11}; do
        LONG_LINE=$LONG_LINE","$LONG_LINE
    done
    i3-msg "[class=feh] $LONG_LINE"
}
if [ $CURRENT_WORKSPACE -gt $WORKSPACE ]; then
    slide_FEH_RIGHT
else
    slide_FEH_LEFT
fi
#SIMPLE KILL AFTER 500ms
{ sleep .5 && kill $FEH_WINDOW; } &
