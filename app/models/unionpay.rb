require 'digest'
require "unionpay/conf"

module Unionpay

  class << self
    attr_accessor :account, :private_key, :server_url, :wws_socket

    def sign(params)
      sign_str = params.sort.map do |k,v|
        "#{k}#{v}" unless Unionpay::SignIgnoreParams.include? k
      end.join
      Digest::MD5.hexdigest("#{sign_str}#{private_key}").upcase
    end

    def environment= e
      case e
      ## 测试环境
      when :development
        self.account = "T100068"
        self.private_key = "T100068"
        self.server_url = "https://222.72.248.198"
        self.wws_socket = "ws://222.72.248.198:8080/push/#{self.account}/#{self.private_key}"
      ## 线上环境
      else
        self.account = "100068"
        self.private_key = "629520f88aa44dee8291f9162ae70842"
        self.server_url = "https://data.unionpaysmart.com"
        self.wws_socket = "wss://push.unionpaysmart.com/push/#{self.account}/#{self.private_key}"
      end
    end
  end
end

