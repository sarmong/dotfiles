(call_expression
(member_expression
  object: (identifier) @_obj (#eq? @_obj "db")
  property: (property_identifier) @_method (#eq? @_method "query")

  )
  (arguments
    [(template_string) (string)]  @sql)
    (#offset! @sql 0 1 0 -1)
)
