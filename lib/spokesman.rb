require 'spokesman/version'
require 'spokesman/config'
require 'spokesman/errors'
require 'spokesman/message'
require 'spokesman/utils'

module Spokesman
  def self.send_sms(text, phones, config = nil)
    Message.new('sms', text, phones, config).send!
  end
end