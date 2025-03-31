import subprocess
from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

# from Xlib import X, display
# from Xlib.ext import xkb


mod = "mod4"
terminal = guess_terminal()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "tab", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    # Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control", "shift"], "r", lazy.restart(), desc="Reload the config"),
    # Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]

groups_primary = [
    {"label": "1", "screen": 0, "name": "01"},
    {"label": "2", "screen": 0, "name": "02"},
    {"label": "3", "screen": 0, "name": "03"},
    {"label": "4", "screen": 0, "name": "04", "add_key": "8"},
    {"label": "5", "screen": 0, "name": "05", "add_key": "9"},
    {"label": "6", "screen": 0, "name": "06", "add_key": "0"},
]
groups_secondary = [
    {"label": "1", "screen": 1, "name": "11"},
    {"label": "2", "screen": 1, "name": "12"},
    {"label": "3", "screen": 1, "name": "13"},
]

all_groups = groups_primary + groups_secondary


def create_group(group_spec):
    return Group(
        name=group_spec["name"],
        label=group_spec["label"],
        screen_affinity=group_spec["screen"],
    )


groups = list(map(create_group, all_groups))


def next_group():
    def _(qtile):
        screen = qtile.current_group.name[0]
        num = qtile.current_group.name[1]
        new_group = screen + str(int(num) + 1)

        if new_group not in qtile.groups_map:
            new_group = screen + "1"

        qtile.groups_map[new_group].toscreen()
        qtile.focus_screen(int(screen))

    return _


def prev_group():
    def _(qtile):
        screen = qtile.current_group.name[0]
        num = qtile.current_group.name[1]
        new_group = screen + str(int(num) - 1)

        if new_group not in qtile.groups_map:
            new_group = screen + "6"

        qtile.groups_map[new_group].toscreen()

    return _


layouts = [
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4, margin=5),
    layout.Max(),
    layout.Tile(),
    # layout.Plasma(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

groupbox1 = widget.GroupBox()
groupbox2 = widget.GroupBox(visible_groups=["8", "9"])


def createmybar(visible_groups):
    return bar.Bar(
        [
            widget.GroupBox(
                visible_groups=visible_groups, disable_drag=True, padding=7
            ),
            widget.CurrentLayout(padding=20),
            widget.Sep(padding=10, linewidth=5),
            # widget.GroupBox(),
            widget.TaskList(),
            widget.Prompt(),
            # widget.KeyboardLayout(configured_keyboards=["us", "ru", "uk"]),
            widget.Systray(),
            widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
        ],
        30,
        margin=0,
        background="#282828",
        # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
        # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
    )


screens = [
    Screen(
        top=createmybar(visible_groups=[item["name"] for item in groups_primary]),
        left=bar.Gap(5),
        right=bar.Gap(5),
        bottom=bar.Gap(5),
    ),
    Screen(
        top=createmybar(visible_groups=[item["name"] for item in groups_secondary]),
        left=bar.Gap(5),
        right=bar.Gap(5),
        bottom=bar.Gap(5),
    ),
]

mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod],
        "Button3",
        lazy.window.set_size(),
        start=lazy.window.get_size(),
        warp_pointer=True,
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="Media viewer"),  # GPG key password entry
        # Match(wm_class="mpv"),
    ]
)


# @hook.subscribe.group_window_add
# def new_client(_, client):
@hook.subscribe.client_managed
# @hook.subscribe.client_new
def new_client(client):
    a = Match(wm_class="safeeyes")
    b = a.compare(client)
    if b:
        # client.enable_floating()
        client.enable_fullscreen()


auto_fullscreen = False
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

wmname = "qtile"


@hook.subscribe.startup_complete
def run_every_startup():
    subprocess.run(["autostart.sh"])


def goto_group(group_spec):
    def _inner(qtile):
        i = qtile.screens.index(qtile.current_screen)
        target_group_name = str(i) + group_spec["label"]
        qtile.groups_map[target_group_name].toscreen()

    return _inner


def move_to_group(group_spec):
    def _inner(qtile):
        i = qtile.screens.index(qtile.current_screen)
        target_group_name = str(i) + group_spec["label"]
        qtile.current_window.togroup(target_group_name, switch_group=False)
        qtile.groups_map[target_group_name].toscreen()

    return _inner


for i in all_groups:
    keys.append(Key([mod], i["label"], lazy.function(goto_group(i))))
    keys.append(Key([mod, "shift"], i["label"], lazy.function(move_to_group(i))))
    if "add_key" in i:
        keys.append(Key([mod], i["add_key"], lazy.function(goto_group(i))))
        keys.append(Key([mod, "shift"], i["add_key"], lazy.function(move_to_group(i))))


def focus_screen():
    def _(qtile):
        i = qtile.screens.index(qtile.current_screen)
        qtile.focus_screen(0 if i == 1 else 1)

    return _


keys.append(Key([mod], "o", lazy.function(focus_screen())))


def latest_group(qtile):
    qtile.current_screen.set_group(qtile.current_screen.previous_group)


keys += [Key([mod], "escape", lazy.function(latest_group))]


keys += [
    Key(
        [mod],
        "w",
        lazy.function(prev_group()),
        desc="Spawn a command using a prompt widget",
    ),
    Key(
        [mod],
        "s",
        lazy.function(next_group()),
        desc="Spawn a command using a prompt widget",
    ),
]


# @hook.subscribe.screens_reconfigured
# async def _():
#     if len(qtile.screens) > 1:
#         groupbox1.visible_groups = ["u", "i", "o", "p"]
#     else:
#         groupbox1.visible_groups = ["u", "i", "o", "p", "8", "9"]
#     if hasattr(groupbox1, "bar"):
#         groupbox1.bar.draw()


groups.append(
    ScratchPad(
        "scratchpad",
        [
            # define a drop down terminal.
            # it is placed in the upper third of screen by default.
            DropDown(
                "term",
                "kitty",
                opacity=1,
                x=0.2,
                y=0,
                width=0.6,
                height=0.4,
                on_focus_lost_hide=False,
            ),
            # define another terminal exclusively for ``qtile shell` at different position
            DropDown(
                "scratch",
                "kitty --working-directory ~/docs/nc -e zsh -c 'nvim -c \"autocmd TextChanged,InsertLeave <buffer> silent write\" scratch.txt ; zsh' ",
                opacity=1,
                x=0.2,
                y=0,
                width=0.6,
                height=0.4,
                on_focus_lost_hide=False,
            ),
        ],
        single=True,
    ),
)
keys += [
    Key([mod], "z", lazy.group["scratchpad"].dropdown_toggle("term")),
    Key([mod], "a", lazy.group["scratchpad"].dropdown_toggle("scratch")),
]
