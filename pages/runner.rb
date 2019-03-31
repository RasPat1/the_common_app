class Runner
  def initialize(user:, orgs:, driver:)
    @user = user
    @orgs = orgs
    @driver = driver
  end

  def apply
    orgs.each do |org|
      org.apply(user: user, driver: driver)
    end
  end
end