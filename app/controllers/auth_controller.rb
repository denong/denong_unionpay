class AuthController < ApplicationController

  respond_to :json

  def card
    @response = Unionpay::Service.auth_card params
  end

  def answer
    @response = Unionpay::Service.auth_answer params
  end

  def status
    @response = Unionpay::Service.auth_status params[:card]
  end
end
