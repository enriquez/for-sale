class ContactsController < ApplicationController
  def create
    @contact = Contact.new(params[:contact])

    if @contact.save
      ContactMailer.deliver_message(@contact)
      flash[:notice] = "Thank you. We will get back to you as soon as possible"
      redirect_to :back
    else
      @products = Product.all
      flash.now[:error] = "<b>There was a problem with your message:</b><br/>" << @contact.errors.full_messages.join("<br/>")
      render :template => 'products/index'
    end
  end
end
