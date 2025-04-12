api.addSearchAlias(
  "i",
  "wikipedia",
  "https://en.wikipedia.org/wiki/",
  "s",
  "https://en.wikipedia.org/w/api.php?action=opensearch&format=json&formatversion=2&namespace=0&limit=40&search=",
  function (response) {
    return JSON.parse(response.text)[1];
  },
);

api.addSearchAlias(
  "b",
  "brave",
  "https://search.brave.com/search?q=",
  "s",
  "https://search.brave.com/api/suggest?q=",
  function (response) {
    return JSON.parse(response.text)[1];
  },
);

api.mapkey("Y", "Md link", function () {
  const removables = [" %E2%80%A2 Instagram photos and videos", " - YouTube"];
  const url = location.href;
  let title = document.title;
  removables.forEach((rem) => {
    if (title.endsWith(rem)) {
      title = title.slice(0, title.indexOf(rem));
    }
  });
  const link = `[${title}](${url})`;
  navigator.clipboard.writeText(link);
});

settings.tabsThreshold = 0;
