class ProductsController < ApplicationController
  before_filter :load_contact

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  protected
  def load_contact
    @contact = Contact.new
  end
end
