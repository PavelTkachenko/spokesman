require 'spec_helper'

describe Spokesman do
  it 'has a version number' do
    expect(Spokesman::VERSION).not_to be nil
  end

  it 'sends SMS' do

    Spokesman.default_config do |config|
      config.login    = 'spokesman'
      config.password = '123456789'
      config.sender   = 'Spokesman'
    end

    expect(Spokesman.send_sms('+77017777777', 'SMS message')).to have_json_type(Integer).at_path('id')
  end
end
