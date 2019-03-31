require 'cgi'

require_relative './adapter'
require_relative '../lib/org'
require_relative '../lib/strategy'

# Tightly coupled to YAML file
# Simply a transport object

class OrgAdapter < Adapter
  def self.build_org(org_data)
    data = {
      name: org_data["name"],
      token: org_data["token"],
      callback_url: CGI.escape(org_data["callback_url"]),
      strategy: org_data["strategy"].capitalize
    }

    validate(data)

    Org.new(data)
  end

  def self.validate(data)
    all_valid = conditions.all? do |condition|
      condition.call
    end

    raise ValidationError.new unless all_valid
  end
end