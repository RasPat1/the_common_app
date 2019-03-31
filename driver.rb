require 'watir'
require './config'

class Driver
  class << self
    def delegate(*fields, to:)
      fields.each do |field|
        define_method(field) do
          self.send(to).send(field)
        end
      end
    end
  end

  attr_reader :browser_instance

  delegate :html, :windows, :link, :button, to: :browser_instance

  def initialize(urls:, browser_instance: Watir::Browser.new)
    @urls = urls
    @browser_instance = browser_instance

    visit(urls[0])
  end

  def visit(url)
    browser_instance.goto(url)
  end

  def iframe_html
    iframe.html
  end

  def element(**args)
    browser_instance.element(**args)
  end

  def execute_script(script, *args)
    browser_instance.execute_script(script, *args)
  end

  def iframe(args)
    browser_instance.iframe(args)
  end

  def click_a_link
    link(href: '/jobs/client-success.html').click
  end

  def fill_in_first_name
    first_name = iframe.text_field(id: 'first_name') 
    first_name.set 'Carlos'
  end

  def apply_with_linked_in
    iframe.button(name: 'button').click

    Watir::Wait.until { windows.size == 2 }
 
    windows[1].wait_while(&:present?)

    iframe.button(id: 'submit_app').click
  end

  def apply_with_linked_in_link
    button(class: 'apply-with-linkedin-button')
  end

  private

  attr_reader :urls
end

