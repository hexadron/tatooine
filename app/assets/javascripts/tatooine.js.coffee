$ ->
  Note.flash()
  
  $(document).on 'click', '.tabs a', ->
    self = $(this)
    li = self.parent()
    ul = self.closest('ul, ol')
    content = $("##{self.data('tab')}")
      
    if content.length > 0
      siblings = li.siblings().find('a')
      
      contents = for sib in siblings
        $("##{$(sib).data('tab')}")
      
      for c in contents
        if c.attr('id') != content.attr('id')
          c.hide()
      
      content.show()
      ul.find('.current').removeClass('current')
      self.addClass('current')
  
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
  
  $('#toggle-search').click ->
    $(this).find('.arrow').toggleClass('down').toggleClass('up')
    $('.search-zone').toggle()
  
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
  