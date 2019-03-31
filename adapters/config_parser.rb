require 'yaml'

require_relative './user_adapter.rb'
require_relative './org_adapter.rb'
require_relative './address_adapter.rb'

class ConfigParser
  attr_reader :user, :orgs

  FILE_PATH = './config/data.yml'

  def initialize
    @yaml_data = YAML.load_file(FILE_PATH)

    address = AddressAdapter.build_address(address_data)

    @user = UserAdapter.build_user(user_data, address)
    @orgs = orgs_data.map do |org_data|
      OrgAdapter.build_org(org_data)
    end
  end

  def self.parse
    new
  end

  def user_data
    @yaml_data["User"]
  end

  def orgs_data
    @yaml_data["Orgs"]
  end

  def address_data
    @yaml_data["Address"]
  end
end