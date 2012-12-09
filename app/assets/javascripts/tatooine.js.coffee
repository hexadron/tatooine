$ ->
  randomColor = ->
    color = '#'
    color += Math.floor(Math.random() * 6) + 3 for i in [1..6]
    return color
  $('.courses').isotope
    itemSelector : 'li'
    layoutMode : 'masonry'
  for course in $('.courses a')
    $(course).css 'background', randomColor()