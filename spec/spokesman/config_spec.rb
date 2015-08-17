require 'spec_helper'

describe Spokesman::Config do

  it 'sets and returns login properly' do
    config = Spokesman.config do |config|
      config.login = 'spokesman'
    end
    expect(config.login).to eq('spokesman')
  end

  it 'raise exception if login is not a string' do
    expect do
      Spokesman.config do |config|
        config.login = :bad_login
      end
    end.to raise_error(ArgumentError)
  end

  it 'sets and returns password properly' do
    config = Spokesman.config do |config|
      config.password = 'password'
    end
    expect(config.password).to eq('password')
  end

  it 'raise exception if password is not a string' do
    expect do
      Spokesman.config do |config|
        config.password = :bad_password
      end
    end.to raise_error(ArgumentError)
  end

  it 'converts password to psw for API' do
    config = Spokesman.config do |config|
      config.password = 'test_psw'
    end
    expect(config.psw).to eq('test_psw')
  end

  it 'sets and returns sender properly' do
    config = Spokesman.config do |config|
      config.sender = 'Spokesman'
    end
    expect(config.sender).to eq('Spokesman')
  end

  it 'raise exception if sender is not a string' do
    expect do
      Spokesman.config do |config|
        config.sender = :bad_sender
      end
    end.to raise_error(ArgumentError)
  end

  it 'raise exception if sender name is not in appropriate format' do
    expect do
      Spokesman.config do |config|
        config.sender = 'Too long name for sender'
      end
    end.to raise_error(ArgumentError)
  end

  it 'sets translit to false by default' do
    config = Spokesman.config {}
    expect(config.translit).to eq(false)
  end

  it 'sets and returns translit option properly' do
    config = Spokesman.config do |config|
      config.translit = true
    end
    expect(config.translit).to eq(true)
  end

  it 'raise exception if translit is not a bool' do
    expect do
      Spokesman.config do |config|
        config.translit = :true
      end
    end.to raise_error(ArgumentError)
  end

  it 'converts false translit in appropriate code for API' do
    config = Spokesman.config do |config|
      config.translit = false
    end
    expect(config.trslit).to eq(0)
  end

  it 'converts true translit in appropriate code for API' do
    config = Spokesman.config do |config|
      config.translit = true
    end
    expect(config.trslit).to eq(1)
  end

  it 'sets charset to utf-8 by default' do
    config = Spokesman.config {}
    expect(config.charset).to eq('utf-8')
  end

  it 'sets and returns charset properly' do
    config = Spokesman.config do |config|
      config.charset = 'windows-1251'
    end
    expect(config.charset).to eq('windows-1251')
  end

  it 'raise exception if charset is not utf-8, windows-1251 or koi8-r' do
    expect do
      Spokesman.config do |config|
        config.charset = 'iso-8859-1'
      end
    end.to raise_error(Spokesman::UnsupportedCharsetError)
  end

  it 'sets and returns timezone properly' do
    config = Spokesman.config do |config|
      config.tz = 0
    end
    expect(config.tz).to eq(0)
  end

  it 'accepts negative fixnum arguments for timezone' do
    config = Spokesman.config do |config|
      config.tz = -6
    end
    expect(config.tz).to eq(-6)
  end

  it 'accepts only Fixnum for timezone as argument' do
    expect do
      Spokesman.config do |config|
        config.tz = 'bad_argument'
      end
    end.to raise_error(ArgumentError)
  end

  it 'sets response format to json by default' do
    config = Spokesman.config {}
    expect(config.response_format).to eq('json')
  end

  it 'sets and returns response format properly' do
    config = Spokesman.config do |config|
      config.response_format = 'simple'
    end
    expect(config.response_format).to eq('simple')
  end

  it 'raise exception if response format is not simple, number, json or xml' do
    expect do
      Spokesman.config do |config|
        config.response_format = 'bad_format'
      end
    end.to raise_error(Spokesman::UnsupportedResponseFormatError)
  end

  it 'converts simple response format in appropriate code for API' do
    config = Spokesman.config do |config|
      config.response_format = 'simple'
    end
    expect(config.fmt).to eq(0)
  end

  it 'converts number response format in appropriate code for API' do
    config = Spokesman.config do |config|
      config.response_format = 'number'
    end
    expect(config.fmt).to eq(1)
  end

  it 'converts json response format in appropriate code for API' do
    config = Spokesman.config do |config|
      config.response_format = 'xml'
    end
    expect(config.fmt).to eq(2)
  end

  it 'converts simple response format in appropriate code for API' do
    config = Spokesman.config do |config|
      config.response_format = 'json'
    end
    expect(config.fmt).to eq(3)
  end

  it 'sets cost not to be returned by default' do
    config = Spokesman.config {}
    expect(config.cost_format).to eq('none')
  end

  it 'sets and returns cost properly' do
    config = Spokesman.config do |config|
      config.cost_format = 'check'
    end
    expect(config.cost_format).to eq('check')
  end

  it 'raise exception if cost is not none, check, simple or balance' do
    expect do
      Spokesman.config do |config|
        config.cost_format = 'bad_format'
      end
    end.to raise_error(Spokesman::UnsupportedCostFormatError)
  end

  it 'converts none cost in appropriate code for API' do
    config = Spokesman.config do |config|
      config.cost_format = 'none'
    end
    expect(config.cost).to eq(0)
  end

  it 'converts check cost in appropriate code for API' do
    config = Spokesman.config do |config|
      config.cost_format = 'check'
    end
    expect(config.cost).to eq(1)
  end

  it 'converts simple cost in appropriate code for API' do
    config = Spokesman.config do |config|
      config.cost_format = 'simple'
    end
    expect(config.cost).to eq(2)
  end

  it 'converts balance cost in appropriate code for API' do
    config = Spokesman.config do |config|
      config.cost_format = 'balance'
    end
    expect(config.cost).to eq(3)
  end

  it 'does not show bad phone numbers by default' do
    config = Spokesman.config {}
    expect(config.show_bad_phone_numbers).to eq(false)
  end

  it 'sets and show_bad_phone_numbers properly' do
    config = Spokesman.config do |config|
      config.show_bad_phone_numbers = true
    end
    expect(config.show_bad_phone_numbers).to eq(true)
  end

  it 'raise exception if show_bad_phone_numbers is not a bool' do
    expect do
      Spokesman.config do |config|
        config.show_bad_phone_numbers = :true
      end
    end.to raise_error(ArgumentError)
  end

  it 'converts false show_bad_phone_numbers in appropriate code for API' do
    config = Spokesman.config do |config|
      config.show_bad_phone_numbers = false
    end
    expect(config.err).to eq(0)
  end

  it 'converts true show_bad_phone_numbers in appropriate code for API' do
    config = Spokesman.config do |config|
      config.show_bad_phone_numbers = true
    end
    expect(config.err).to eq(1)
  end

  it 'does not show log by default' do
    config = Spokesman.config {}
    expect(config.show_log).to eq(false)
  end

  it 'sets and show_log properly' do
    config = Spokesman.config do |config|
      config.show_log = true
    end
    expect(config.show_log).to eq(true)
  end

  it 'raise exception if show_log is not a bool' do
    expect do
      Spokesman.config do |config|
        config.show_log = :true
      end
    end.to raise_error(ArgumentError)
  end

  it 'converts false show_log in appropriate code for API' do
    config = Spokesman.config do |config|
      config.show_log = false
    end
    expect(config.op).to eq(0)
  end

  it 'converts true show_log in appropriate code for API' do
    config = Spokesman.config do |config|
      config.show_log = true
    end
    expect(config.op).to eq(1)
  end

  it 'sets and returns default config' do
    Spokesman.default_config {}
    expect(Spokesman::Config.default.class).to eq(Spokesman::Config)
  end

  it 'builds hash query' do
    config = Spokesman.config do |config|
      config.login       = 'spokesman'
      config.cost_format = 'balance'
      config.tz          = -2
    end
    expect(config.query).to eq({ login: 'spokesman', translit: 0, charset: 'utf-8', 
                                 tz: -2, cost: 3, fmt: 3, err: 0, op: 0 })
  end
end
