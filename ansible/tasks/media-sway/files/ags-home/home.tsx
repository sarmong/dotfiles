import { App, Astal, Gtk } from "astal/gtk4";
import { execAsync, exec } from "astal/process";
import { Variable } from "astal";

export const confirmVisible = Variable(false);

const time = Variable("").poll(1000, "date '+%H:%M'");

// True when any regular xdg_toplevel window is open under sway.
// Layer-shell surfaces (ags itself) aren't in get_tree, so this
// only counts real apps: firefox, mpv, etc.
const hasApp = Variable(false).poll(
  1500,
  ["sh", "-c", "swaymsg -t get_tree | jq '[recurse(.nodes[]?) | select(.pid)] | length'"],
  (out) => parseInt(out.trim() || "0") > 0,
);

type Tile = { label: string; action: () => void };

const tiles: Tile[] = [
  {
    label: "Jellyfin",
    action: () => exec(["firefox", "--kiosk", "http://localhost:8096/web"]),
  },
  { label: "Music", action: () => execAsync(["notify-send", "Music tile"]) },
  { label: "YouTube", action: () => execAsync(["notify-send", "YouTube tile"]) },
  { label: "Web", action: () => execAsync(["firefox", "--kiosk"]) },
  { label: "Exit", action: () => App.quit() },
];

function HomeWindow() {
  return (
    <window
      application={App}
      name="home"
      visible={hasApp((v) => !v)}
      layer={Astal.Layer.TOP}
      anchor={
        Astal.WindowAnchor.TOP |
        Astal.WindowAnchor.BOTTOM |
        Astal.WindowAnchor.LEFT |
        Astal.WindowAnchor.RIGHT
      }
      keymode={Astal.Keymode.ON_DEMAND}
      cssClasses={["home"]}
    >
      <box hexpand vexpand vertical halign={Gtk.Align.FILL} valign={Gtk.Align.FILL}>
        <box cssClasses={["topbar"]} halign={Gtk.Align.END} hexpand>
          <label label={time()} cssClasses={["clock"]} />
        </box>
        <box vexpand vertical halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER} spacing={40}>
          <label label="TV" cssClasses={["title"]} />
          <box spacing={24} cssClasses={["tile-row"]}>
            {tiles.map((t, i) => (
              <button
                onClicked={t.action}
                cssClasses={["tile"]}
                setup={(self) => {
                  if (i === 0) self.grab_focus();
                }}
              >
                <label label={t.label} />
              </button>
            ))}
          </box>
        </box>
      </box>
    </window>
  );
}

function CloseOverlay() {
  return (
    <window
      application={App}
      name="close-overlay"
      visible={hasApp()}
      layer={Astal.Layer.OVERLAY}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT}
      keymode={Astal.Keymode.ON_DEMAND}
      cssClasses={["close-overlay-win"]}
    >
      <button onClicked={() => execAsync(["swaymsg", "kill"])} cssClasses={["close-app"]}>
        <label label="× Close App" />
      </button>
    </window>
  );
}

function ConfirmExit() {
  return (
    <window
      application={App}
      name="confirm-exit"
      visible={confirmVisible()}
      layer={Astal.Layer.OVERLAY}
      anchor={
        Astal.WindowAnchor.TOP |
        Astal.WindowAnchor.BOTTOM |
        Astal.WindowAnchor.LEFT |
        Astal.WindowAnchor.RIGHT
      }
      keymode={Astal.Keymode.EXCLUSIVE}
      cssClasses={["confirm-overlay-win"]}
      onKeyPressed={(_, keyval) => {
        // XF86Back keysym is 0x1008FF26; close on Back
        if (keyval === 0x1008ff26) {
          confirmVisible.set(false);
          return true;
        }
        return false;
      }}
    >
      <box
        hexpand
        vexpand
        halign={Gtk.Align.CENTER}
        valign={Gtk.Align.CENTER}
        vertical
        spacing={32}
        cssClasses={["confirm-card"]}
      >
        <label label="Exit?" cssClasses={["confirm-title"]} />
        <box spacing={32} halign={Gtk.Align.CENTER}>
          <button
            cssClasses={["confirm-yes"]}
            onClicked={() => {
              confirmVisible.set(false);
              execAsync(["swaymsg", "kill"]);
            }}
            setup={(self) => self.grab_focus()}
          >
            <label label="Yes" />
          </button>
          <button cssClasses={["confirm-no"]} onClicked={() => confirmVisible.set(false)}>
            <label label="No" />
          </button>
        </box>
      </box>
    </window>
  );
}

export default function Home() {
  HomeWindow();
  // CloseOverlay();
  ConfirmExit();
}
