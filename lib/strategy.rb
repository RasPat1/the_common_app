class Strategy
  TYPES = [
    GREENHOUSE = :greenhouse
  ]

  def apply(*args)
    # no-op
  end

  def self.valid_type?(type)
    TYPES.include?(type)
  end

  def self.fetch_class(type)
    raise UnknownStrategyError.new unless valid_type?(type)

    case type
    when GREENHOUSE
      Object.get_const("Greenhouse")
    else
    end

  end
end