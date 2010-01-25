class Admin::PhotosController < Admin::BaseController
  before_filter :load_parent

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(params[:photo])
    @parent.photos << @photo if @parent
    
    if params[:Filedata]
      @photo.swf_uploaded_data = params[:Filedata]
      @photo.save!
      
      photo_with_hidden_id = "<input type=\"hidden\" id=\"photo_#{@photo.id}\" name=\"#{params[:parent]}[photo_ids][]\" value=\"#{@photo.id}\" /><img src=\"#{@photo.file.url(:small)}\" style=\"margin:5px\" />"
      render :text => photo_with_hidden_id
    end
  end
  
  def edit
    @photo = Photo.find(params[:id])
  end
  
  def update
    @photo = Photo.find(params[:id])
    
    if @photo.update_attributes(params[:photo])
      flash[:notice] = "Photo was updated"
      redirect_to polymorphic_path([:admin, @parent])
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:notice] = "Photo was deleted"
    redirect_to :back
  end
  
  private
  def load_parent
    @parent = Product.find(params[:product_id]) if product?
  end
  
  def product?
    !params[:product_id].blank?
  end
end
