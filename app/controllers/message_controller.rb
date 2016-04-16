require "net/http"
require 'open-uri'
require "uri"
class MessageController < ApplicationController
  def get
    api_key = 'f765df6a-112f-4f20-ae65-424467831991'
    puts params[:message]
    uri = URI.parse("http://sandbox.api.simsimi.com/request.p?key=#{api_key}&lc=en&ft=1.0&text=#{URI::encode(params[:message])}")

    response = Net::HTTP.get_response(uri)
    render json: response.body
  end
end
