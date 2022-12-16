class ValueStruct
  def self.attributes(&)
    include ValueSemantics.for_attributes(&)
  end

  def self.try_new(**params)
    value_struct = new(**params)
    Success.new(value_struct)
  rescue ValueSemantics::MissingAttributes, ValueSemantics::InvalidValue => e
    Failure.new(e.message)
  end

  def self.coerce_date(value)
    case value
    when String
      begin
        Date.strptime(value, '%Y-%m-%d')
      rescue ArgumentError
        value
      end
    else
      value
    end
  end

  def self.coerce_string(value)
    value.to_s
  end

  def self.coerce_time(value)
    case value
    when String
      begin
        Time.parse(value).utc
      rescue ArgumentError
        value
      end
    else
      value
    end
  end

  class Success
    attr_reader :value

    def initialize(value_struct)
      @value = value_struct
    end

    def success?
      true
    end

    def error
      nil
    end
  end

  class Failure
    attr_reader :error

    def initialize(error)
      @error = error
    end

    def success?
      false
    end

    def value
      nil
    end
  end

  DateCoercer = method(:coerce_date)
  StringCoercer = method(:coerce_string)
  TimeCoercer = method(:coerce_time)

  private_constant :DateCoercer
  private_constant :StringCoercer
  private_constant :TimeCoercer
end
