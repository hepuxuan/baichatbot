require "net/http"
require 'open-uri'
require "uri"
require 'json'
require "#{Rails.root}/app/services/simsimi_service.rb"

class MessageController < ApplicationController
  @@simsimi_service = SimSimiService.new()
  @@default_response_list = [
    'mew!mew!mew',
    '喵喵喵!',
    'wait a sec, GIVE ME TREATS and then I\'ll talk to you',
    'Don\'t care, I need to get some sleep'
  ]

  @@default_message_list = [
    'hihihi',
    'TALK TO ME!',
    'Are you still there?',
    'where are you buddy'
  ]
  def get
    response = {}
    if (params[:message].present?)
      response = @@simsimi_service.getResponse(params[:message])
      response['response'] = @@default_response_list[rand(@@default_response_list.size)] unless response.has_key?('response')
    else
      response['response'] = @@default_message_list[rand(@@default_message_list.size)]
    end

    render json: {response: response['response']}
  end
end
