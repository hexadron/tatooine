$.fn.realHeight = ->
  visibleParent = @closest(':visible').children()
  visibleParent.addClass('temp-show')
  thisHeight = @outerHeight()
  visibleParent.removeClass('temp-show')
  
  thisHeight

# Empuja la página hacia abajo.
pushPage = (height, speed) ->
  page = $('.page')
  originalMTop = page.css('marginTop')
  origMTopNum = +originalMTop.match(/\d+/)[0]
  
  page.data('originalMTop', originalMTop)
  page.animate marginTop: origMTopNum + height, speed

restorePage = (speed) ->
  page = $('.page')
  page.animate marginTop: page.data('originalMTop'), speed

# El tiempo que una alerta permanezca depende de la longitud de la cadena.
# En este caso, consideramos que 1 segundo para 15 letras es un buen tiempo.
timeFor = (str) ->
  (str.length / 15) * 1000

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
    top = -form.outerHeight()
    form.animate {top: top}, 600, ->
      callback?()
  
  reallyBring: (form, fn) ->
    top = $('.header.menu').height()
    form.animate(top: top, 600, fn)
  
  notice: (text) ->
    noti = $("<div class='notification'></div>")
    noti.append("<p>#{text}</p>")
    duration = timeFor text
    
    noti.insertAfter('.header')
    
    rHeight = noti.realHeight()
    
    pushPage(rHeight, 500)
    
    noti.slideDown 500, ->
      setTimeout ->
        restorePage(600)
        noti.slideUp(600).addClass('consumed')
      , duration
    
  flash: ->
    notifs = $('.notification:not(.consumed)')
    duration = timeFor notifs.text()
    rHeight = notifs.realHeight()
    
    if notifs.length > 0
      pushPage(rHeight, 500)
      notifs.slideDown 500, ->
        setTimeout ->
          restorePage(600)
          notifs.slideUp(600).addClass('consumed')
        , duration

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
  
  form.find('.perform').off('click').on 'click', ->
    $.rails.confirmed link
    Note.closeForm '#form-of-destruction'
  
  Note.bringForm "#form-of-destruction"