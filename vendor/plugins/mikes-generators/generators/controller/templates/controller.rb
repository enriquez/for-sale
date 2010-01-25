<% if class_nesting.present? && options[:include_base_controller] -%>
class <%= class_name %>Controller < <%= class_nesting %>::BaseController
<% else -%>
class <%= class_name %>Controller < ApplicationController
<% end -%>
<% for action in actions -%>
  def <%= action %>
  end

<% end -%>
end
