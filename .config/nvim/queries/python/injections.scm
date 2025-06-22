(
  (string
    (string_content) @sql)
  (#match? @sql "(?i)\\b(SELECT|INSERT|UPDATE|DELETE|WITH|CREATE|DROP)\\b")
  (#set! injection.language "sql")
)
