require_relative './adapters/config_parser'
require_relative './runner.rb'

class App
  def initialize
    config = ConfigParser.parse

    @user = config.user
    @orgs = config.orgs

    @runner = Runner.new(user: @user, orgs: @orgs)
  end

  def apply
    @runner.apply
  end
end