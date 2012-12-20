Note =
  bringForm: (selector, inCallback, outCallback) ->
    form = $(selector)
    @attachCancel(form, outCallback)
    @reallyBring(form, inCallback)
  
  submit: (selector, fn) ->
    $(selector).on 'submit', (evt) ->
      evt.preventDefault()
      fn?()
  
  attachCancel: (form, callback) ->
    form.find('.cancel').one 'click', (evt) =>
      evt.preventDefault()
      @closeForm $(evt.target).closest('.notform'), callback
  
  closeForm: (form, callback) ->
    top = form.data('top')
    form.animate {top: top}, 600, ->
      callback?()
  
  reallyBring: (form, fn) ->
    top = $('.header.menu').height()
    old_top = form.css('top')
    form.data('top', old_top)
    form.animate(top: top, 400, fn)
    
  flash: ->
    notifs = $('.notification:not(.consumed)')
    if notifs.length > 0
      notifs.fadeIn 400, ->
        setTimeout ->
          notifs.fadeOut(400).addClass('consumed')
        , 4200

window.Note = Note