# encoding: utf-8

require "faraday"
require 'open-uri'

module Unionpay
  class Service
    class << self

      def auth_card auth_info

        user_id = auth_info.respond_to?(:user_id) ? auth_info.user_id : auth_info[:user_id]
        card = auth_info.respond_to?(:card) ? auth_info.card : auth_info[:card]
        name = auth_info.respond_to?(:name) ? auth_info.name : auth_info[:name]
        mobile = auth_info.respond_to?(:mobile) ? auth_info.mobile : auth_info[:mobile]

        params = {
          account: Unionpay.account,
          authType: 1,
          userId: user_id,
          card: card,
          name: name,
          mobile: mobile
        }
        sign = Unionpay.sign(params)
        params[:sign] = sign

        connection = Faraday::Connection.new Unionpay.server_url,  { ssl: { verify: false } }
        response = connection.get '/auth/card', params
        puts response.body
      end

      def auth_status card
        params = {
          account: Unionpay.account,
          card: card,
        }
        sign = Unionpay.sign(params)
        params[:sign] = sign

        connection = Faraday::Connection.new Unionpay.server_url,  { ssl: { verify: false } }
        response = connection.get 'auth/authStatus', params
        puts response.body
      end


      def auth_answer answer_info
        user_id = auth_info.respond_to?(:user_id) ? auth_info.user_id : auth_info[:user_id]
        card = auth_info.respond_to?(:card) ? auth_info.card : auth_info[:card]
        answer = auth_info.respond_to?(:answer) ? auth_info.answer : auth_info[:answer]

        params = {
          account: Unionpay.account,
          userId: user_id,
          card: card,
          answer: answer
        }
        sign = Unionpay.sign(params)
        params[:sign] = sign
        connection = Faraday::Connection.new Unionpay.server_url,  { ssl: { verify: false } }
        response = connection.get 'auth/answer', params
        puts response.body
      end
    end
    
  end
end