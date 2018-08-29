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
    if @inquiry.valid?
      InquiryMailer.received_email(@inquiry).deliver
    else
      raise
    end
  end

  
  private
  
  def inquiry_params
    params.require(:inquiry).permit(:email, :title, :message)
  end
end
