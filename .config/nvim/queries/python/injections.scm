(
  (string
    (string_content) @injection.content
    (#match? @injection.content ".*(SELECT|INSERT|UPDATE|DELETE|CREATE|DROP).*")
    (#set! injection.language "sql")
  )
)
