module Spokesman
  class Message
    attr_reader :type, :phone, :text, :params
    
    def initialize(type, phone, text, config = nil)
      @type   = type
      @phone  = phone
      @text   = text
      @params = Config.default.query
      unless  config.nil?
        raise UnsupportedConfigError if config.class != Config
        @params = params.merge(config.query)
      end
    end

    def query
      { 
        type:   type,
        phones: phone,
        mes:    text
      }.merge(params)
    end
  end
end