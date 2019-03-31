require_relative '../lib/strategy'
require 'byebug'

class Greenhouse < Strategy
  attr_reader :org, :org_name, :token, :callback_url

  def initialize(org:, org_name:, token:, callback_url: nil)
    @org = org
    @org_name = org_name
    @token = token
    @callback_url = callback_url
  end

  def apply(user:, driver:)
    # visit the greenhouse page
    driver.visit(url)

    # Get all the fields that need to be filled for this org
    all_fields = fields + org.org_custom_fields

    # fill in the generic fields
    fill(driver: driver, user: user, fields: all_fields)

    # hit submit....
    submit(driver: driver)

    sleep 100
  end

  def url
    base = "https://boards.greenhouse.io/embed/job_app"
    q_params = "?for=#{@org_name}&token=#{@token}"
    unless @callback_url.nil? || @callback_url.empty?
      q_params += "&b=#{@callback_url}"
    end

    base + q_params
  end

  def fill(driver:, user:, fields:)
    fields.each do |field|
      data = user.send(field[:user_field_name])
      field_type = field[:type]

      finder_key = field[:preferred_finder_name].to_sym
      finder = {}
      finder[finder_key] = field[finder_key]
      driver.send(:safe_delegate, field_type, finder).set(data)
    end
  end

  def submit(driver:)
    driver.button(id: 'submit_app').click
  end

  def fields
    # A list of fields that this strategy uses
    # Each field should have a way of "filling in" for this strategy
    # careful there is some coupling to driver browser instance implementation
    [
      # These should be objects
      {
        type: 'text_field',
        id: 'first_name',
        preferred_finder_name: 'id',
        user_field_name: :first_name,
      },
      {
        type: 'text_field',
        id: 'last_name',
        preferred_finder_name: 'id',
        user_field_name: :last_name,
      },
      {
        type: 'text_field',
        id: 'email',
        preferred_finder_name: 'id',
        user_field_name: :email,
      },
      {
        type: 'text_field',
        id: 'phone',
        preferred_finder_name: 'id',
        user_field_name: :phone,
      },
      # then there are a bunch of drop downs
    ]
  end

end