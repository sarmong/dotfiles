;; query
;; STRING SQL INJECTION
; (
;  (template_string) @sql (#match? @sql "^`\n*( )*-{2,}( )*[sS][qQ][lL]( )*\n")
;  )
;
; (
;  (
;   (comment) @_comment (#match? @_comment "sql") 
;   (lexical_declaration 
;     (variable_declarator
;       [ (string (string_fragment) @sql)
;        (template_string) @sql ]
;       )
;     )
;   )
;  @sql)


  ; ((template_string)  @sql
  ; (#offset! @sql 0 1 0 -1))

  (
   (comment) @_lang (#eq? @_lang "/* js */")
   (template_string)  @javascript
  (#offset! @javascript 0 1 0 -1))

; (
;   (comment) @injection.language (#match? @injection.language "js")
;   (template_string)  @injection.content
;   (#offset! @injection.content 0 1 0 -1)
;   (#set! injection.language "sql")
; )

; ; html(`...`), html`...`, sql(...) etc
; (call_expression
;   function: (identifier) @injection.language
;   arguments:
;     [
;       (arguments
;         (template_string) @injection.content)
;       (template_string) @injection.content
;     ]
;   (#lua-match? @injection.language "^[a-zA-Z][a-zA-Z0-9]*$")
;   (#offset! @injection.content 0 1 0 -1)
;   (#set! injection.include-children)
;   ; Languages excluded from auto-injection due to special rules
;   ; - svg uses the html parser
;   ; - css uses the styled parser
;   (#not-any-of? @injection.language "svg" "css"))
