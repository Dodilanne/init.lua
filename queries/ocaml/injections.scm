(extension
  (attribute_id) @tag (#eq? @tag "html")
  (attribute_payload
    (expression_item
      (application_expression
        (quoted_string 
        (quoted_string_content) @injection.content)
      )
    )
  ) 
  (#set! injection.language "html")
  (#set! injection.combined)
)
(extension
  (attribute_id) @tag (#eq? @tag "html")
  (attribute_payload
    (expression_item
      (string
        (string_content) @injection.content
      )
    ) 
  ) 
  (#set! injection.language "html")
  (#set! injection.combined)
)

