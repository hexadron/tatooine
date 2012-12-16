$ ->
  
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
  