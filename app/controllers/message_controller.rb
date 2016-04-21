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
    'en' => [
      'mew!mew!mew',
      'Sorry I do not understand you',
      'Excuse me?'
    ],
    'cn' => [
      '恁说了个啥??',
      '人家听不懂哎'
    ]
  }

  @@idle_message_list = {
    'en' => [
      'hihihi',
      'TALK TO ME!',
      'Are you still there?',
      'where are you buddy',
      'please don\'t ignore me'
    ],
    'cn' => [
      '喵喵喵!',
      '在吗',
      '跟人家说会话嘛',
      '喵喵喵喵喵喵 :#'
    ]
  }

  def get
    if (params[:message].present?)
      response = service.getResponse(params[:message])
      default_response = @@default_response_list[lang]
      response = default_response[rand(default_response.size)] unless response.present?
      render json: {response: response}
    else
      render json: {error: 'message is missing'}, status: 412
    end
  end

  def get_idle
    idle_response = @@idle_message_list[lang]
    response = idle_response[rand(idle_response.size)]
    render json: {response: response}
  end

  private

  def lang
    params[:lang].present? ? params[:lang] : 'en'
  end

  def service()
    case params[:lang]
    when 'cn'
      service = @@douqq_service
    else
      service = @@simsimi_service
    end
  end
end
