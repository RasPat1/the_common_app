require './driver'
require 'forwardable'

class Page
  extend Forwardable

  def initialize(driver: Driver.new(urls: [self.class::URL]))
    @driver = driver
  end

  private

  attr_reader :driver
  def_delegators :driver, :html, :windows, :link, :button
end