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

user_pref("browser.ml.enable", false); // general switch for machine learning features in Firefox (https://www.reddit.com/r/firefox/comments/1obbrvz/how_to_completely_get_rid_of_the_ai_stuff/nki10g9/), though it might not completely disable all features (https://bugzilla.mozilla.org/show_bug.cgi?id=1971973#c11)
user_pref("browser.ml.chat.enabled", false); // AI Chatbot (https://docs.openwebui.com/tutorials/integrations/firefox-sidebar/#additional-about-settings)
user_pref("browser.ml.chat.sidebar", false);
user_pref("browser.ml.chat.menu", false); // remove "Ask a chatbot" from tab context menu
user_pref("browser.ml.chat.page", false); // remove option from page context menu
user_pref("extensions.ml.enabled", false); // might only be relevant for app developers
user_pref("browser.ml.linkPreview.enabled", false);
user_pref("browser.ml.pageAssist.enabled", false);
user_pref("browser.ml.smartAssist.enabled", false);
user_pref("browser.tabs.groups.smart.enabled", false); // "Use AI to suggest tabs and a name for tab groups" in settings
user_pref("browser.tabs.groups.smart.userEnabled", false);
user_pref("pdfjs.enableAltTextModelDownload", false); // "This prevents downloading the AI model unless the user opts in (by enabling the toggle to "Create alt text automatically" from "Image alt text settings" when viewing a PDF)"
user_pref("pdfjs.enableGuessAltText", false); // (disabling this might be redundant when AltTextModelDownload is disabled)

user_pref("extensions.webcompat-reporter.enabled", false); // disable Web Compatibility Reporter which adds a "Report Site Issue" button to send data to Mozilla
user_pref("extensions.screenshots.disabled", true);
user_pref("extensions.screenshots.upload-disabled", true);
user_pref("screenshots.browser.component.enabled", false);
user_pref("media.videocontrols.picture-in-picture.enabled", false);
user_pref("browser.tabs.notes.enabled", false); // adding notes to tabs
user_pref("browser.tabs.splitView.enabled", false); // split tab option
user_pref("sidebar.visibility", "hide-sidebar");
// note that the new sidebar can also be disabled (sidebar.revamp=false) but only temporarily https://blog.nightly.mozilla.org/2026/01/13/phasing-out-the-older-version-of-firefox-sidebar-in-2026/
user_pref("pdfjs.enableAltText", false); // alt-text in pdf
user_pref("pdfjs.enableAltTextForEnglish", false); // alt-text in pdf

// Disabling addons recommendations/etc.
user_pref("browser.discovery.enabled", false); // [SETTING] Privacy & Security>Firefox Data Collection & Use>...>Allow Firefox to make personalized extension recs (This pref has no effect when Health Reports are disabled)
user_pref("extensions.htmlaboutaddons.discover.enabled", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref(
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons",
  false,
); // "Recommend extensions as you browse"
user_pref(
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features",
  false,
); // "Recommend features as you browse"
user_pref("extensions.webservice.discoverURL", "");
user_pref("extensions.getAddons.discovery.api_url", "");
user_pref("extensions.getAddons.showPane", false);
user_pref("browser.dataFeatureRecommendations.enabled", false);
user_pref("pfs.datasource.url", ""); // remove plugin finder service
