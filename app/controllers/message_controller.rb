require "net/http"
require 'open-uri'
require "uri"
require 'json'
require "#{Rails.root}/app/services/simsimi_service.rb"

class MessageController < ApplicationController
  @@simsimi_service = SimSimiService.new()
  @@idle_message_list = [
    'hihihi',
    'TALK TO ME!',
    'Are you still there?',
    'where are you buddy',
    'please don\'t ignore me',
    'Seriously you are hurting my feeling'
  ]
  def get
    response = {}
    if (params[:message].present?)
      response = @@simsimi_service.getResponse(params[:message])
    else
      response = @@idle_message_list[rand(@@idle_message_list.size)]
    end

    render json: {response: response}
  end
end
