module Spokesman
  def self.config(&block)
    Config.set(&block)
  end

  class Config
    @@login                  = nil
    @@password               = nil
    @@sender                 = nil
    @@translit               = false
    @@charset                = 'utf-8'
    @@tz                     = nil
    @@response_format        = 'json'
    @@cost_format            = 'none'
    @@show_bad_phone_numbers = false
    @@show_log               = false

    def self.set(&block)
      instance_eval(&block)
    end

    def self.login=(login)
      raise ArgumentError if login.class != String
      @@login = login
    end

    def self.password=(password)
      raise ArgumentError if password.class != String
      @@password = password
    end

    def self.sender=(sender)
      raise ArgumentError if sender.class != String
      raise ArgumentError if !sender.match(/\A[a-zA-Z0-9 .,-_]{1,11}\z/)
      @@sender = sender
    end

    def self.translit=(true_or_false)
      raise ArgumentError unless [true, false].include?(true_or_false)
      @@translit = true_or_false
    end

    def self.charset=(charset)
      raise ArgumentError if charset.class != String
      raise UnsupportedCharsetError unless ['urf-8', 'koi8-r', 'windows-1251'].include?(charset)
      @@charset = charset
    end

    def self.tz=(tz)
      raise ArgumentError if tz.class != Fixnum
      @@tz = tz
    end

    def self.response_format=(response_format)
      raise ArgumentError if response_format.class != String
      raise UnsupportedResponseFormatError unless ['simple', 'number', 'json', 'xml'].include?(response_format)
      @@response_format = response_format
    end

    def self.cost_format=(cost_format)
      raise ArgumentError if cost_format.class != String
      raise UnsupportedCostFormatError unless ['none', 'check', 'simple', 'balance'].include?(cost_format)
      @@cost_format = cost_format
    end

    def self.show_bad_phone_numbers=(true_or_false)
      raise ArgumentError unless [true, false].include?(true_or_false)
      @@show_bad_phone_numbers = true_or_false
    end

    def self.show_log=(true_or_false)
      raise ArgumentError unless [true, false].include?(true_or_false)
      @@show_log = true_or_false
    end

    def self.login
      @@login
    end

    def self.password
      @@password
    end

    def self.sender
      @@sender
    end

    def self.translit
      @@translit
    end

    def self.charset
      @@charset
    end

    def self.tz
      @@tz
    end

    def self.response_format
      @@response_format
    end

    def self.cost_format
      @@cost_format
    end

    def self.show_bad_phone_numbers
      @@show_bad_phone_numbers
    end

    def self.show_log
      @@show_log
    end

    def self.fmt
      { 'simple' => 0, 'number' => 1, 'xml' => 2, 'json' => 3 }.values_at(response_format)[0]
    end

    def self.cost
      { 'none' => 0, 'check' => 1, 'simple' => 2, 'balance' => 3 }.values_at(cost_format)[0]
    end

    def self.err
      show_bad_phone_numbers ? 1 : 0
    end

    def self.op
      show_log ? 1 : 0
    end
  end
end
