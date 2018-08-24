class InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    render :new unless @inquiry.valid?
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.save
  end
  
  def complete
  end
  
  private
  
  def inquiry_params
    params.require(:inquiry).permit(:email, :title, :message)
  end
end
