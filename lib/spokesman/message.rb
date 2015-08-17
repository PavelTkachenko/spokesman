require "net/http"
require "uri"

module Spokesman
  class Message
    attr_reader :type, :phone, :text, :params
    
    def initialize(type, phone, text, config = nil)
      @type   = type
      @phone  = Utils.sanitize_phone(phone)
      @text   = Utils.urlify(text)
      @params = Config.default.query
      unless  config.nil?
        raise UnsupportedConfigError if config.class != Config
        @params = params.merge(config.query)
      end
    end

    def query
      { 
        phones: phone,
        mes:    text
      }.merge(params)
    end

    def post
      uri = URI('http://smsc.ru/sys/send.php')
      res = Net::HTTP.post_form(uri, query)
      res.body
    end
  end
end