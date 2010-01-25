module Admin::ProductsHelper
  def navigation_items
    [
      { :name => "List Products", :path => admin_products_path },
      { :name => "Create a Product", :path => new_admin_product_path }
    ]
  end
end
