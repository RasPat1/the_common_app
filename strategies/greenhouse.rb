require_relative '../lib/strategy'
require_relative '../strategy_adapters/greenhouse_adapter'
require 'byebug'

class Greenhouse < Strategy
  attr_reader :org, :org_name, :token, :callback_url

  SKIP_FINDER = :skip

  def initialize(
      org:,
      org_name:,
      token:,
      callback_url: nil,
      adapter: GreenhouseAdapter.new
    )
    @org = org
    @org_name = org_name
    @token = token
    @callback_url = callback_url
    @adapter = adapter
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
    @adapter.bind(user: user)

    fields.each do |field|
      data = @adapter.fetch(field[:user_field_name])
      field_type = field[:type]

      finder_key = field[:preferred_finder_name].to_sym

      finder = {}

      if finder_key != SKIP_FINDER
        finder[finder_key] = field[finder_key]
      end

      driver
        .send(:safe_delegate, field_type, finder)
        .send(field[:mutate_keyword], data)
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
        mutate_keyword: :set,
      },
      {
        type: 'text_field',
        id: 'last_name',
        preferred_finder_name: 'id',
        user_field_name: :last_name,
        mutate_keyword: :set,
      },
      {
        type: 'text_field',
        id: 'email',
        preferred_finder_name: 'id',
        user_field_name: :email,
        mutate_keyword: :set,
      },
      {
        type: 'text_field',
        id: 'phone',
        preferred_finder_name: 'id',
        user_field_name: :phone,
        mutate_keyword: :set,
      },

      # then there are a bunch of drop downs
      {
        type: 'select_list',
        id: 'job_application_gender',
        preferred_finder_name: 'id',
        user_field_name: :gender,
        mutate_keyword: :select,
      },
      {
        type: 'select_list',
        id: 'job_application_hispanic_ethnicity',
        preferred_finder_name: 'id',
        user_field_name: :hispanic_latino,
        mutate_keyword: :select,
      },
      {
        type: 'select_list',
        id: 'job_application_veteran_status',
        preferred_finder_name: 'id',
        user_field_name: :veteran_status,
        mutate_keyword: :select,
      },
      {
        type: 'select_list',
        id: 'job_application_disability_status',
        preferred_finder_name: 'id',
        user_field_name: :disability_status,
        mutate_keyword: :select,
      },

      # Then there is uploading a resume
      {
        type: 'file_field',
        preferred_finder_name: SKIP_FINDER,
        user_field_name: :resume_path,
        mutate_keyword: :set,
      },
    ]
  end

end