require_relative './strategy'
require_relative '../strategies/greenhouse'

class Org
  def initialize(name:, token:, callback_url:, strategy:)
    @name = name
    @token = token
    @callback_url = callback_url
    @strategy = strategy
  end

  def apply(user:, driver:)
    klass = Object.const_get(@strategy)
    klass.new(
      org_name: @name,
      token: @token,
      callback_url: @callback_url
    ).apply(user: user, driver: driver)
  end

end