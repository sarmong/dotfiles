;; extends

; (shortcut_link
;   [
;     "["
;     "-"
;     "]"
;   ] @todo_in_progress
;  (#offset! @todo_in_progress 0 -2 0 0)
;   (#set! conceal "⧖"))

(shortcut_link
  [
    "["
  ] @markup.link
  (#set! conceal "["))
(shortcut_link
  [
    "]"
  ] @markup.link
  (#set! conceal "]"))
