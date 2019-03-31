require './driver'

class Page
  class << self
    def delegate(*fields, to:)
      fields.each do |field|
        define_method(field) do
          self.send(to).send(field)
        end
      end
    end
  end

  delegate :html, :windows, :link, :button, to: :driver

  def initialize(driver: Driver.new(urls: [self.class::URL]))
    @driver = driver
  end

  private

  attr_reader :driver
end
