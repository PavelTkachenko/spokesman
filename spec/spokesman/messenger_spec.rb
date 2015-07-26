require 'spec_helper'

describe Spokesman::Messenger do

  before do
    Spokesman.config do |config|
      config.login    = 'spokesman'
      config.password = '123456789'
      config.sender   = 'Spokesman'
    end
    number  = '+77014929242'
    message = 'This is spec message'
  end

  it 'sends sms' do
    expect(Spokesman.send_sms(number, message)).to eq(true)
  end
end