require 'spec_helper'

describe Spokesman::Message do

  Spokesman.default_config do |config|
    config.login    = 'spokesman'
    config.password = '123456789'
    config.sender   = 'Spokesman'
  end
  let(:number) { '+77014929242' }
  let(:text) { 'This is spec message' }

  it 'merges provided config with default config' do
    config = Spokesman.config do |config|
      config.sender      = 'Changed'
      config.cost_format = 'balance'
    end
    message = Spokesman::Message.new('sms', number, text, config)
    expect(message.params).to eq({ login: 'spokesman', password: '123456789', sender: 'Changed', 
                                   translit: false, charset: 'utf-8', cost: 3, fmt: 3, err: 0, op: 0 })
  end

  it 'builds query for request' do
    message = Spokesman::Message.new('sms', number, text)
    expect(message.query).to eq(1)
  end
end