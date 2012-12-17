#= require active_admin/base

$ ->

  $('.password_edit_switcher input').click ->
      edit = $(@).is(':checked')
      futureDisplay = if edit then 'block' else 'none'
      $('.password_part').css 'display', futureDisplay
