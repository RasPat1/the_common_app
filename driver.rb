require 'watir'
require 'forwardable'

class Driver
  extend Forwardable
  attr_reader :browser_instance

  def initialize(browser_instance: nil)
    @browser_instance = browser_instance || default_browser
  end

  def default_browser
    args = ['--auto-open-devtools-for-tabs']
    Watir::Browser.new :chrome, options: { args: args }
  end

  def visit(url)
    browser_instance.goto(url)
  end

  def iframe_html
    iframe.html
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

    wait_until_user_exits_window_and_shit

    windows[1].wait_while(&:present?)

    iframe.button(id: 'submit_app').click
  end

  def wait_until
    Watir::Wait.until { yield }
  end

  def wait_until_user_exits_window_and_shit
    Watir::Wait.until { windows.size == 1 }
  end

  def apply_with_linked_in_link
    button(class: 'apply-with-linkedin-button')
  end

  def safe_delegate(field_type, finder)
    # byebug
    safe_field = Driver.delegatable_methods.include?(field_type.to_sym)
    raise StandardError.new("Delegate Error") unless safe_field
    self.send(field_type, finder)
  end

  def self.delegatable_methods
    [:html, :windows, :link, :button, :element, :text_field]
  end

  private
  attr_reader :urls

  def_delegators :browser_instance, *delegatable_methods
end