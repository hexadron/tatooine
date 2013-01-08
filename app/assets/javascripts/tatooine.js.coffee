$.fn.redraw = ->
  old_overflow = @css('overflow')
  @hide 0, ->
    $(this).show()
    $(this).css('overflow', old_overflow)

$ ->
  Note.flash()
  
  $(document).on 'click', '.help-trigger a', ->
    $(this).parent().find('.help-text').toggle()
  
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
            width: 100
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

  for course in $('.course_tile')
    $course = $(course)
    if avatar = $course.data('avatar')
      $course.css('background-image', "url(#{avatar})").addClass('with-image')
    else
      $course.css 'background', randomColor()

  $('.courses').isotope
    itemSelector : 'li'
    layoutMode : 'masonry'
  
  # SORTABLE
  $(".section-list ul").sortable
    items: '.section-element'
    update: (evt, ui) ->
      url = $(this).data('url')
      params = { sections: $(this).sortable('toArray') }
      $.post(url, params)
  
  # TABS A_LA_ITUNES
  $('.expander').click ->
    self = $(this)
    
    if box_id = self.data('expanded')
      box = $("##{box_id}")
    else
      box = self.closest('.expansion').find('.expanded')
      
    box.realHeight()
    box.slideToggle ->
      $("body").redraw()
      window.SELF = self
      if toggleText = self.data('textToggle')
        current = self.text()
        texts = toggleText.split("|").map($.trim)
        
        console.log current, texts[0], texts[1]
        
        if current == texts[0]
          self.text(texts[1])
        else
          self.text(texts[0])
        
  
  # FULL-FIXED INDEX OF SECTIONS
  ios = $('.index-of-sections')
  ios.height(ios.height())
  ul = ios.find('ul')
  
  trottle = 55
  
  ul.waypoint((evt, direction) ->
    self = $(this)
    self.css 'width', self.css('width')
    if direction is 'down'
      self.css
        position: 'fixed'
        top: trottle
        left: self.offset().left
    else
      self.css
        position: 'relative'
        top: 0
        left: 0
  , offset: trottle).on 'click', 'a', (evt) ->
    evt.preventDefault()
    elem = $($(this).attr('href'))
    $('html, body').animate({
      scrollTop: elem.offset().top - 150
    }, 700)