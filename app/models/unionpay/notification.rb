# encoding: utf-8

module Unionpay
  class Notification
    def start
      EM.run do

        puts "before connect"
        ws = WebSocket::EventMachine::Client.connect(uri: Unionpay.wws_socket)
        puts "to be connect"

        ws.onopen do
          puts "Connected"
        end

        ws.onmessage do |msg, type|
          puts "Received message: #{msg}"
        end

        ws.onclose do |code, reason|
          puts "Disconnected with status code: #{code}"
        end

        EventMachine.next_tick do
          puts "in next_tick"
          # ws.send "Hello Server!"
        end

      end
    end
  end
end