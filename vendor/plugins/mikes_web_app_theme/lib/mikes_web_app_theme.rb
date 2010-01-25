module MikesWebAppTheme
  def controller_body_id
    controller_name.gsub(/_/, '-')
  end
  
  def main_navigation_li name, path, options
    if options[:controller] == controller_body_id || options[:controller].blank?
      options[:class] ||= ""
      options[:class] << " active"
    end
    
    content = content_tag "li", :class => options[:class], :id => options[:controller] do
      link_to name, path
    end
    content
  end
  
  def block_to_partial(partial_name, options = {}, &block)
    options.merge!(:body => capture(&block))
    concat(render(:partial => partial_name, :locals => options))
  end

  def main_block(secondary_title, navigation_items, active_item = nil, include_flashes = true, &block)
    secondary_navigation = set_navigation_classes(navigation_items, active_item)
    block_to_partial("web_app_theme/main_block", {
        :include_flashes => include_flashes,
        :secondary_navigation => secondary_navigation,
        :secondary_title => secondary_title },
      &block)
  end

  def sidebar_block(title, &block)
    block_to_partial("web_app_theme/sidebar_block", {
      :title => title
    }, &block)
  end

  def form_field_group f, method, options = {}
    field_label = f.label(method, options[:input_label], :class => "label")
    field_error = f.error_message_on method
    field_input = case options[:input_type]
    when :text_area
      f.text_area(method, :class => "text_area")
    when :password_field
      f.password_field(method, :class => "text_field")
    when :file_field
      f.file_field(method, :class => "file_field")
    when :check_box
      field_label = label_tag(method.to_s, options[:input_label], :class => "label")
      content_tag :div do
        f.check_box(method, :class => "checkbox") << f.label(method, options[:check_box_label], :class => "checkbox")
      end
    when :check_boxes
      field_label = label_tag(method.to_s, options[:input_label], :class => "label")
      method_ids = "#{method.to_s.singularize}_ids"
      choices = ""
      options[:select_choices].each do |choice|
        div = content_tag(:div) do
          check_box_tag("#{f.object.class.to_s.downcase}[#{method_ids}][]", choice.last, options[:checked_choices].include?(choice.first), {:class => "checkbox", :id => choice.first.to_url}) << label_tag(choice.first.to_url, choice.first, :class => "checkbox")
        end
        choices << div
      end

      choices
    when :select
      f.select(method, options[:select_choices], {}, :html_options => {:class => "select"})
    else
      f.text_field(method, :class => "text_field")
    end

    if options[:description]
      field_label << content_tag(:span, :class => "description") do
        options[:description]
      end
    end

    content_tag :div, :class => "group" do
      field_label << field_error << field_input
    end
  end

  def form_button f, options = {}
    button = f.submit(options[:button_text], :class => "button")
    cancel_link = link_to "Cancel", options[:cancel_path]

    content_tag :div, :class => "group" do
      button << " or " << cancel_link
    end
  end

  def validation_error_flash object, message = "There was a problem with your input"
    if object.errors.size > 0
      content_tag :div, :class => "flash" do
        content_tag :div, :class => "message error" do
          content_tag :p do
            message
          end
        end
      end
    end
  end

  def set_navigation_classes navigation_items, active_position = nil
    items = navigation_items
    items.each do |navigation_item|
      navigation_item[:class] = ""
    end
    items.first[:class] = "first "
    items[active_position][:class] << "active" if active_position
    items
  end
end