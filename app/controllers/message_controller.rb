require "net/http"
require 'open-uri'
require "uri"
require 'json'
require "#{Rails.root}/app/services/simsimi_service.rb"

class MessageController < ApplicationController
  @@simsimi_service = SimSimiService.new()
  
  def get
    default_response_list = [
      'mew!mew!mew',
      '喵喵喵!',
      'wait a sec, GIVE ME TREATS and then I\'ll talk to you',
      'Dn\'t care, I need to get some sleep'
    ]

    response = @@simsimi_service.getResponse(params[:message])
    if !response[:response]
       response[:response] = default_response_list[rand(default_response_list.size)]
    end

    render json: {response: response[:response]}
  end
end
