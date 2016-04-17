require "net/http"
require 'open-uri'
require "uri"

class DouQQService
  @@API_KEY = 'WVJBNGNoMmhEUG5GdW1Hck49R2NQT0E9WndVQUFBPT0'
  def getResponse(message)
    uri = URI.parse("http://api.douqq.com/?key=#{@@API_KEY}&msg=#{URI::encode(message)}")
    response = Net::HTTP.get_response(uri).body.force_encoding('UTF-8')
    if response.include? '这是小豆机器人微信号'
      nil
    else
      response
    end
  end
end
