require 'erb'
module Spokesman
  class Utils
    include ERB::Util

    def self.urlify(string)
      ERB::Util.url_encode(string)
    end

    def self.sanitize_phone(phone)
      phone.gsub(/[^0-9]/, '')
    end
  end
end