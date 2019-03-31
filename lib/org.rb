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
      org: self,
      org_name: @name,
      token: @token,
      callback_url: @callback_url
    ).apply(user: user, driver: driver)
  end

  def org_custom_fields
    # no-op
    # The organization subclass handles any elements of the application that are specific to it's webpage/process.
  end




  # lists all organization names that have custom options
  # enabled. We can enable and disable custom org logic here
  # Typically we'd pull this from a config
  # We coudl also have org do the mapping forma string to a class
  # This way we allow enabled and disabled logic as well as possible aliasing to work here. It'll all work equally well at this point. Just keep moving.
  def self.manifest
    # keep these all lowercase for now
    ['evernote']
  end

  def self.default_org
    'generic_org'
  end
end