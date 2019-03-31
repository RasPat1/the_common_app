require './page'

class Evernote < Page
  URL = 'https://evernote.com/careers/job/?id=1386988&gh_jid=1386988'

  def iframe
    driver
      .iframe(id: 'grnhse_iframe')
      .wait_until(&:present?).tap { |thing| thing.click }
  end

  def run
    iframe.iframe.wait_until(&:present?)

    driver.visit(iframe.attribute_value('src'))

    inner_iframe = driver.element(tag_name: 'iframe')

    inner_iframe.wait_until(&:present?) 

    sleep 2

    inner_iframe.execute_script(
      <<~JS
        document.getElementsByTagName("button")[0].click()
      JS
    )

    while true; sleep 1; end

    self
  end

  def success
    true
  end
end

Evernote.new.run
