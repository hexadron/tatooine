require 'htmlentities'

module CoursesHelper
  
  def markdown(text)
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(:hard_wrap => true),
      :no_intraemphasis => true,
      :autolink => true,
      :fenced_code_blocks => true,
      :lax_html_blocks => true)
    
    sanitize(markdown.render(text)).html_safe
  end
  
  def sanitize(html)
    dont_sanitize_inside_pre_or_code = lambda { |env|
      node = env[:node]
      if node.ancestors('pre,code').size > 0
        node.replace HTMLEntities.new.encode(node.to_s)
        { node_whitelist: [node] }
      end
    }
    
    options = {
      elements: %w{a abbr b blockquote br cite code dd dfn dl dt em i kbd li mark ol p pre q s samp small strike strong sub sup time u ul var img video audio object iframe h1 h2 h3 div},
      add_attributes: { 'a' => { 'target' => '_blank' } },
      attributes: {
        'iframe'  => %w{allowfullscreen frameborder height src width},
        'a' => %w{href},
        'img' => %w{src alt} },
      transformers: dont_sanitize_inside_pre_or_code
    }
    
    Sanitize.clean(html, options)
  end
end