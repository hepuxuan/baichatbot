require "net/http"
require 'open-uri'
require "uri"
require 'json'
class SimSimiService
  @@API_KEY = 'WVJBNGNoMmhEUG5GdW1Hck49R2NQT0E9WndVQUFBPT0'
  def getResponse(message)
    uri = URI.parse("http://api.douqq.com/?key=#{@@API_KEY}&msg=#{URI::encode(message)}")
    Net::HTTP.get_response(uri).body.force_encoding('UTF-8')
  end
end
