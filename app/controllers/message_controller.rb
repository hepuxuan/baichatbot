require "net/http"
require 'open-uri'
require "uri"
require 'json'
require "#{Rails.root}/app/services/simsimi_service.rb"
require "#{Rails.root}/app/services/douqq_service.rb"

class MessageController < ApplicationController
  @@simsimi_service = SimSimiService.new()
  @@douqq_service = DouQQService.new()
  @@default_response_list = {
    eng: [
      'mew!mew!mew',
      'wait a sec, GIVE ME TREATS and then I\'ll talk to you',
      'Don\'t care, I need to get some sleep',
      'Sorry I do not understand you',
      'Excuse me?'
    ],
    chn: [
      '恁说了个啥??',
      '人家听不懂哎'
    ]
  }

  @@idle_message_list = {
    eng: [
      'hihihi',
      'TALK TO ME!',
      'Are you still there?',
      'where are you buddy',
      'please don\'t ignore me'
    ],
    chn: [
      '喵喵喵!',
      '在吗',
      '跟人家说会话嘛',
      '喵喵喵喵喵喵 :#'
    ]
  }

  def get
    if (params[:message].present?)
      response = @@douqq_service.getResponse(params[:message])
      default_response = @@default_response_list[:chn]
      response = default_response[rand(default_response.size)] unless response.present?
      render json: {response: response}
    else
      render json: {error: 'message is missing'}, status: 412
    end
  end

  def getIdle
    idle_response = @@idle_message_list[:chn]
    response = idle_response[rand(idle_response.size)]
    render json: {response: response}
  end
end
