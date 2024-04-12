  ; (jsx_expression
  ;  (comment) @_lang (#match? @_lang "js")
  ;  (template_string)  @javascript
  ; (#offset! @javascript 0 1 0 -1))

   ; ((template_string)  @javascript)

; Styled Jsx <style jsx>
(jsx_element
  (jsx_opening_element
    (identifier) @_name
    (#eq? @_name "script")
    )
  (jsx_expression
    ((template_string) @injection.content
      (#set! injection.language "javascript"))
    (#offset! @injection.content 0 1 0 -1)))

; (
;   (comment) @injection.language (#match? @injection.language "js")
;   (template_string)  @injection.content
;   (#offset! @injection.content 0 1 0 -1)
;   (#set! injection.language "sql")
; )

