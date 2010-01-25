module SpanErrorMessages
  def self.included(base)
    ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
      "<span class='error'>#{html_tag}</span>"
    end
  end
      
  def error_message_on(object, method, *args)
    options = args.extract_options!
    unless args.empty?
      ActiveSupport::Deprecation.warn('error_message_on takes an option hash instead of separate ' +
        'prepend_text, append_text, and css_class arguments', caller)

      options[:prepend_text] = args[0] || ''
      options[:append_text] = args[1] || ''
      options[:css_class] = args[2] || 'formError'
    end
    options.reverse_merge!(:prepend_text => '', :append_text => '', :css_class => 'formError')

    if (obj = (object.respond_to?(:errors) ? object : instance_variable_get("@#{object}"))) &&
      (errors = obj.errors.on(method))
      content_tag("span",
        "#{options[:prepend_text]}#{ERB::Util.html_escape(errors.is_a?(Array) ? errors.first : errors)}#{options[:append_text]}",
        :class => options[:css_class]
      )
    else
      ''
    end
  end
end