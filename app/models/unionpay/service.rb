# encoding: utf-8

require "faraday"
require 'open-uri'

module Unionpay
  class Service
    class << self

      # 校验卡的信息
      def auth_card auth_info

        user_id = auth_info.respond_to?(:user_id) ? auth_info.user_id : auth_info[:user_id]
        card = auth_info.respond_to?(:card) ? auth_info.card : auth_info[:card]
        name = auth_info.respond_to?(:name) ? auth_info.name : auth_info[:name]
        mobile = auth_info.respond_to?(:mobile) ? auth_info.mobile : auth_info[:mobile]
        auth_type = auth_info.respond_to?(:auth_type) ? auth_info.auth_type : auth_info[:auth_type]

        params = {
          account: Unionpay.account,
          authType: auth_type,
          userId: user_id,
          card: card,
          name: name,
          mobile: mobile
        }
        sign = Unionpay.sign(params)
        params[:sign] = sign

        connection = Faraday::Connection.new Unionpay.server_url,  { ssl: { verify: false } }
        response = connection.get '/auth/card', params
        # logger.info response.body
        MultiJson.load  response.body
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
        # logger.info response.body
        MultiJson.load response.body
      end

      # 银行卡的认证答案，短信验证的话传入的是短信验证码
      def auth_answer answer_info
        user_id = answer_info.respond_to?(:user_id) ? answer_info.user_id : answer_info[:user_id]
        card = answer_info.respond_to?(:card) ? answer_info.card : answer_info[:card]
        answer = answer_info.respond_to?(:answer) ? answer_info.answer : answer_info[:answer]

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
        # logger.info response.body
        MultiJson.load  response.body
      end


      def auth_finish card
        params = {
          account: Unionpay.account,
          card: card,
        }
        sign = Unionpay.sign(params)
        params[:sign] = sign

        connection = Faraday::Connection.new Unionpay.server_url,  { ssl: { verify: false } }
        response = connection.get 'auth/finish', params
        # logger.info response.body
        MultiJson.load response.body
      end
      
    end

end