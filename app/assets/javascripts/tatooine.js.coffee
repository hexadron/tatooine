$ ->
  $('.tabs a').click ->
    $('.tabcontent').hide()
    $("##{$(this).data('tab')}").show()
    $('.current').removeClass('current')
    $(this).addClass('current')
  
  # Notifications
  notifs = $('.notification')
  if notifs.length > 0
    setTimeout ->
      notifs.fadeOut(1000)
    , 1200
  
  # Previews
  $('input[type=file][data-preview]').on 'change', (evt) ->
    if @files and window.FileReader
      previewElement = $($(this).data('preview'))
      origWidth = previewElement.width()
      
      reader = new FileReader()
      
      reader.onload = ((previewElement) ->
        (evt) ->
          previewElement.attr
            src: evt.target.result
            width: origWidth
      )(previewElement)
      
      if image = @files[0]
        reader.readAsDataURL(image)
  
  $('#toggle-search').click -> $('.search-zone').toggle()
  
  $('.datepicker').datepicker()
  
  randomColor = ->
    color = '#'
    color += Math.floor(Math.random() * 6) + 3 for i in [1..6]
    return color

  for course in $('.courses a:not(.actions)')
    $(course).css 'background', randomColor()

  $('.courses').isotope
    itemSelector : 'li'
    layoutMode : 'masonry'
  