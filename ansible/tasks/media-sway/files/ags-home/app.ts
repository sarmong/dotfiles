import { App } from "astal/gtk4";
import style from "./style.css";
import Home, { confirmVisible } from "./home";

App.start({
  css: style,
  main() {
    Home();
  },
  requestHandler(request, res) {
    if (request === "confirm-exit") {
      // Toggle: if already visible, hide; else show.
      // Sway's XF86Back binding sends "confirm-exit" each press, giving the
      // "press Back to dismiss" semantics.
      confirmVisible.set(!confirmVisible.get());
      res("ok");
      return;
    }
    res("unknown");
  },
});
