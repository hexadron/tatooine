Note =
  bringForm: (selector, fn) ->
    form = $(selector)
    @attachCancel(form)
    @reallyBring(form, fn)
  
  submit: (selector, fn) ->
    $(selector).on 'submit', (evt) ->
      evt.preventDefault()
      fn?()
  
  attachCancel: (form) ->
    form.find('.cancel').one 'click', (evt) =>
      evt.preventDefault()
      @closeForm $(evt.target).closest('.notform')
  
  closeForm: (form) ->
    top = form.data('top')
    form.animate(top: top)
  
  reallyBring: (form, fn) ->
    top = $('.header.menu').height()
    old_top = form.css('top')
    form.data('top', old_top)
    form.animate(top: top, 400, fn)
    
  flash: ->
    notifs = $('.notification')
    if notifs.length > 0
      setTimeout ->
        notifs.fadeOut(1000)
      , 1200

window.Note = Note