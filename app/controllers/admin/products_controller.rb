class Admin::ProductsController < Admin::BaseController
  helper "admin/photos"

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])

    if @product.save
      flash[:success] = "Product was created"
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
  
    if @product.update_attributes(params[:product])
      flash[:notice] = 'Product was updated'
      redirect_to :action => :index
    else
      render :action => "edit"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:success] = "Product was deleted"
    redirect_to :action => :index
  end

end
