require "net/http"
require 'open-uri'
require "uri"
require 'json'
class SimSimiService
  @@API_KEY = 'ee933cb5-35a5-4397-b76f-7cf6d5dd941f'
  def getResponse(message)
    uri = URI.parse("http://api.simsimi.com/request.p?key=#{@@API_KEY}&lc=en&ft=1.0&text=#{URI::encode(message)}")
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)['response']
  end
end