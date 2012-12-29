module ApplicationHelper
  def link_to_javascript(content, attrs = {})
    link_to(content, "javascript:void(0);", attrs)
  end
  
  def are_you_enrolled?(course)
    current_user.courses.include?(course)
  end
  
  def format_errors(model)
    errors = model.errors.full_messages
    errors.map do |error|
      "<li><p>#{error}</p></li>"
    end.join.html_safe
  end
  
  def avatar_image_data(model, size=:medium)
    image_data(model, :avatar, size)
  end
  
  # Paint the best color for an image background
  def color_style_from_image(model, property, size=:thumb)
    if model.send(property).exists?
      image = model.send(property).path(size)
      best_color = text_color_for_image(image)
      
      { style: "color: #{best_color};" }
    else
      Hash.new
    end
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
