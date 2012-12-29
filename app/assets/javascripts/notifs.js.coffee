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
    form = $(form)
    top = form.data('top')
    form.animate {top: top}, 600, ->
      callback?()
  
  reallyBring: (form, fn) ->
    top = $('.header.menu').height()
    old_top = form.css('top')
    form.data('top', old_top)
    form.animate(top: top, 600, fn)
  
  notice: (text) ->
    noti = $("<div class='notification'></div>")
    noti.append("<p>#{text}</p>")
    noti.insertAfter('.header').slideDown 500, ->
      setTimeout ->
        noti.slideUp(600).addClass('consumed')
      , 4200
    
  flash: ->
    notifs = $('.notification:not(.consumed)')
    if notifs.length > 0
      notifs.slideDown 500, ->
        setTimeout ->
          notifs.slideUp(600).addClass('consumed')
        , 4200

window.Note = Note

# This will override the default "Confirm" included in Rails with button_to :destroy

$.rails.allowAction = (link) ->
  return true unless link.attr('data-confirm')
  $.rails.showConfirmDialog(link)
  false

$.rails.confirmed = (link) ->
  link.removeAttr('data-confirm')
  link.trigger('click.rails')

# An ugly implementation, but meh, i want to try :)
$.rails.showConfirmDialog = (link) ->
  message = link.attr 'data-confirm'
  
  form = $('#form-of-destruction')
  form.find('.message').text(message)
  
  form.find('.perform').one 'click', ->
    $.rails.confirmed link
    Note.closeForm '#form-of-destruction'
  
  Note.bringForm "#form-of-destruction"