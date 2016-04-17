require "net/http"
require 'open-uri'
require "uri"
require 'json'
class SimSimiService
  @@API_KEY = 'f765df6a-112f-4f20-ae65-424467831991'
  def getResponse(message)
    uri = URI.parse("http://sandbox.api.simsimi.com/request.p?key=#{@@API_KEY}&lc=en&ft=1.0&text=#{URI::encode(message)}")
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end
end

