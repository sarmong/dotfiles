user_pref("extensions.pocket.enabled", false);
user_pref("app.update.auto", false);
user_pref("app.update.checkInstallTime", false);

user_pref("browser.startup.homepage", "/var/www/cabin/index.html");

user_pref("accessibility.typeaheadfind.enablesound", false);
user_pref("accessibility.typeaheadfind.flashBar", 0);
user_pref("findbar.highlightAll", true);

user_pref("browser.compactmode.show", true);
user_pref("browser.uidensity", 1);
user_pref("browser.search.separatePrivateDefault.urlbarResult.enabled", false);

user_pref("devtools.chrome.enabled", true); // To debug browser custom css
user_pref("devtools.debugger.remote-enabled", true);

// original pdf colors when in dark mode
user_pref("pdfjs.forcePageColors", true);
user_pref("pdfjs.pageColorsBackground", "CanvasText");
user_pref("pdfjs.pageColorsForeground", "Canvas");

// Enables support for custom user stylesheets (userChrome.css and userContent.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Youtube fullscreen will open within the limits of the OS window
user_pref("full-screen-api.ignore-widgets", true);

// Privacy
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
