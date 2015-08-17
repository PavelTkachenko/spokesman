require 'spec_helper'

describe Spokesman::Message do

  Spokesman.default_config do |config|
    config.login    = 'spokesman'
    config.password = '123456789'
    config.sender   = 'Spokesman'
  end
  let(:number) { '+77014929242' }
  let(:text) { "This is spec message #{Time.now.to_i}" } # Time.now for handle duplication restriction

  it 'merges provided config with default config' do
    config = Spokesman.config do |config|
      config.sender      = 'Changed'
      config.cost_format = 'balance'
    end
    message = Spokesman::Message.new('sms', number, text, config)
    expect(message.params).to eq({ login: 'spokesman', psw: '123456789', sender: 'Changed', 
                                   translit: 0, charset: 'utf-8', cost: 3, fmt: 3, err: 0, op: 0 })
  end

  it 'builds query for request' do
    message = Spokesman::Message.new('sms', number, text)
    expect(message.query).to eq({ phones: '77014929242', mes: Spokesman::Utils.urlify(text), 
                                  login: 'spokesman', psw: '123456789', sender: 'Spokesman', 
                                  translit: 0, charset: 'utf-8', cost: 0, fmt: 3, err: 0, op: 0 })
  end

  it 'makes post request' do
    message = Spokesman::Message.new('sms', number, text)
    response = message.send!
    expect(response).to have_json_type(Integer).at_path('id')
    expect(response).to have_json_type(Integer).at_path('cnt')
  end
end