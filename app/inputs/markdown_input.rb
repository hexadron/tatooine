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
    code, persist = get_code_data
    
    "<div id='#{builder.object ? builder.object.class.to_s.downcase : ''}_#{method}_mdeditor' class='mdeditor #{persist}' data-content=\"#{code}\"></div>".html_safe
  end
  
  def get_code_data
    obj = builder.object
    if obj.nil?
      code = if options[:input_html]
        options[:input_html][:value]
      else
        ""
      end
      persist = false
    else
      code = (obj.send(method.to_sym) or '').gsub("\"", "&#34;")    
      persist = obj.new_record? ? 'persist' : ''
    end
    
    [code, persist]
  end
  
end