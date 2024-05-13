(command
 name: (command_name) @_name (#eq? @_name "jq")
 [
  argument: (raw_string) @jq
  argument: (string (string_content) @jq )
  ]
 (#offset! @jq 0 1 0 -1)
)

(command
 name: (command_name) @_name (#eq? @_name "awk")
 [
  argument: (raw_string) @awk
  argument: (string) @awk
  ]
 (#offset! @awk 0 1 0 -1)
)
