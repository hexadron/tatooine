$ ->
  
  $('.tabs a').click ->
    $('.tabcontent').hide()
    $("##{$(this).data('tab')}").show()
    $('.current').removeClass('current')
    $(this).addClass('current')
  
  notifs = $('.notification')
  if notifs.length > 0
    setTimeout ->
      notifs.fadeOut(1000)
    , 1200
  
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
  