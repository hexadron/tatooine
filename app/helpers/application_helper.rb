module ApplicationHelper
  
  # Text: Texto para el Tile
  # Link: Link al que dirigirá el tile
  # Options:
  # Background -> [model, :attribute]
  def tile_to(text, link, options=nil, html_options={})
    final_html_opts = { class: 'course_tile' }.merge(html_options)
    
    if options and options[:background]
      bg_model, bg_prop, size = options[:background]
      prop_image_data = image_data(bg_model, bg_prop, (size or :tile))
      color_style = color_style_from_image(bg_model, bg_prop)
      
      final_html_opts = final_html_opts.merge(prop_image_data).merge(color_style)
    end
    
    link_to(content_tag(:span, text), link, final_html_opts)
  end
  
  def course_tile_to(course)
    tile_to course.name, course_url(course), background: [course, :background_image]
  end
  
  def link_to_javascript(content, attrs = {})
    link_to(content, "javascript:void(0);", attrs)
  end
  
  def are_you_enrolled?(course)
    return false if current_user.nil?
    current_user.courses.include?(course)
  end
  
  def format_errors(model_or_array)
    if model_or_array.class == Array
      errors = model_or_array
    else
      errors = model_or_array.errors.full_messages
    end
    lis = errors.map do |error|
      "<li><p>#{error}</p></li>"
    end.join
    
    "<ul>#{lis}</ul>".html_safe
  end
  
  def avatar_image_data(model, size=:medium)
    image_data(model, :avatar, size)
  end
  
  # Pinta un color dependiendo del color predominante de una imagen.
  # En Heroku, la gema Miro no funciona.
  # Fix rápido: Begin / Rescue.
  def color_style_from_image(model, property, size=:thumb)
    if model.send(property).exists?
      image = model.send(property).url(size)
      best_color = text_color_for_image(image)
      { style: "color: #{best_color};" }
    else
      Hash.new
    end
  rescue => e
    Rails.logger.warn(e)
    Hash.new
  end
  
  private
  
  # Get the best color for an image background
  def text_color_for_image(image)
    dominant = dominant_color(image)
    brightness = brightness(dominant)
    # Por ahora sólo devolvemos blanco o negro.
    # Si lo vemos muy feo, pensar una solución
    # más inteligente.
    if brightness < 255 / 2
      "#fff"
    else
      "#000"
    end
  end
  
  # Retorna un valor entre 0 y 255
  def brightness(color)
    r, g, b = color
    # http://stackoverflow.com/a/596243
    0.299 * r + 0.587 * g + 0.114 * b
  end
  
  def dominant_color(image)
    colors = Miro::DominantColors.new(image)
    colors.to_rgb.first
  end
  
  def image_data(model, property, size)
    if model.send(property).exists?
      { data: { avatar: model.send(property).url(size) } }
    else
      Hash.new
    end
  end
end