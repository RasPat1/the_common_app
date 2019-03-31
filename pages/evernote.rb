require './page'
require 'pry'

class Evernote < Page
  URL = 'https://evernote.com/careers/job/?id=1386988&gh_jid=1386988'

  def iframe
    @iframe ||= driver
      .iframe(id: 'grnhse_iframe')
      .wait_until(&:present?).tap { |thing| thing.click }
  end

  def extract_source(iframe)
    iframe.attribute_value('src')
  end

  def run
    start = driver.iframe(id: 'grnhse_iframe')

    js_hack = "return document.getElementsByTagName('button')[0].click()"
    js_check = "return document.getElementsByTagName('button').length"

    sleep 2
    start.iframe
    start.iframe.button
    start.iframe.button.click

    driver.wait_until do
      value = start.iframe.execute_script(js_check)
      value > 0
    end

    start.iframe.execute_script(js_hack)
    driver.wait_until_user_exits_window_and_shit

    self
  end

  def success
    true
  end
end

Evernote.new.run