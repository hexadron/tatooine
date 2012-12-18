$ ->
  $('#bring_section_form').click ->
    Note.bringForm '#new_section_form', ->
      $('#section_title').focus()
    