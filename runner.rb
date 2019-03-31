require_relative './driver.rb'

class Runner
  def initialize(user:, orgs:, driver: nil)
    @user = user
    @orgs = orgs
    @driver = driver || Driver.new
  end

  def apply
    @orgs.each do |org|
      org.apply(user: @user, driver: @driver)
    end
  end
end