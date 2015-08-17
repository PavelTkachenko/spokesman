module Spokesman
  def self.default_config(&block)
    Config.set_default(&block)
  end

  def self.config(&block)
    Config.set(&block)
  end

  class Config
    @@default_config = nil

    attr_reader :login, :password, :sender, :translit, :charset, :tz, :response_format, 
                 :cost_format, :show_bad_phone_numbers, :show_log

    def self.set_default(&block)
      @@default_config ||= Config.new
      @@default_config.instance_eval(&block)
    end

    def self.default
      @@default_config
    end

    def self.set(&block)
      config = Config.new
      config.instance_eval(&block)
      config
    end

    def login=(login)
      raise ArgumentError if login.class != String
      @login = login
    end

    def password=(password)
      raise ArgumentError if password.class != String
      @password = password
    end

    def sender=(sender)
      raise ArgumentError if sender.class != String
      raise ArgumentError if !sender.match(/\A[a-zA-Z0-9 .,-_]{1,11}\z/)
      @sender = sender
    end

    def translit=(true_or_false)
      raise ArgumentError unless [true, false].include?(true_or_false)
      @translit = true_or_false
    end

    def charset=(charset)
      raise ArgumentError if charset.class != String
      raise UnsupportedCharsetError unless ['urf-8', 'koi8-r', 'windows-1251'].include?(charset)
      @charset = charset
    end

    def tz=(tz)
      raise ArgumentError if tz.class != Fixnum
      @tz = tz
    end

    def response_format=(response_format)
      raise ArgumentError if response_format.class != String
      raise UnsupportedResponseFormatError unless ['simple', 'number', 'json', 'xml'].include?(response_format)
      @response_format = response_format
    end

    def cost_format=(cost_format)
      raise ArgumentError if cost_format.class != String
      raise UnsupportedCostFormatError unless ['none', 'check', 'simple', 'balance'].include?(cost_format)
      @cost_format = cost_format
    end

    def show_bad_phone_numbers=(true_or_false)
      raise ArgumentError unless [true, false].include?(true_or_false)
      @show_bad_phone_numbers = true_or_false
    end

    def show_log=(true_or_false)
      raise ArgumentError unless [true, false].include?(true_or_false)
      @show_log = true_or_false
    end

    def translit
      @translit || false
    end

    def charset
      @charset || 'utf-8'
    end

    def response_format
      @response_format || 'json'
    end

    def cost_format
      @cost_format || 'none'
    end

    def show_bad_phone_numbers
      @show_bad_phone_numbers || false
    end

    def show_log
      @show_log || false
    end

    def fmt
      { 'simple' => 0, 'number' => 1, 'xml' => 2, 'json' => 3 }.values_at(response_format)[0]
    end

    def cost
      { 'none' => 0, 'check' => 1, 'simple' => 2, 'balance' => 3 }.values_at(cost_format)[0]
    end

    def err
      show_bad_phone_numbers ? 1 : 0
    end

    def op
      show_log ? 1 : 0
    end

    def trslit
      translit ? 1 : 0
    end

    def psw
      password
    end

    def query
      {
        login:    login,
        psw:      psw,
        sender:   sender,
        translit: trslit,
        charset:  charset,
        tz:       tz,
        cost:     cost,
        fmt:      fmt,
        err:      err,
        op:       op
      }.reject {|key, value| value.nil? }
    end
  end
end
