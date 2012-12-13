class MarkdownInput
  include Formtastic::Inputs::Base
  
  def to_html
    input_wrapping do
      label_html <<
      builder.hidden_field(method, {}) <<
      markdown_editor
    end
  end
  
  def markdown_editor
    obj = builder.object
    code = (obj.send(method.to_sym) or '').gsub("\"", "&#34;")
    persist = obj.new_record? ? 'persist' : ''
    "<div id='#{builder.object.class.to_s.downcase}_#{method}_mdeditor' class='mdeditor #{persist}' data-content=\"#{code}\"></div>".html_safe
  end
  
end