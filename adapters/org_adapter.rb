require 'cgi'

require_relative './adapter'
require_relative '../lib/org'
require_relative '../lib/strategy'
require_relative '../lib/util'

Dir[File.join(__dir__, '..', 'orgs', '*.rb')].each { |file| require file }

# Tightly coupled to YAML file
# Simply a transport object
# Also decides which subclass of organization to implement
class OrgAdapter < Adapter
  def self.build_org(org_data)
    data = {
      name: org_data["name"],
      token: org_data["token"],
      callback_url: CGI.escape(org_data["callback_url"]),
      strategy: org_data["strategy"].capitalize
    }

    validate(data)

    build_custom_org(name: data[:name], data: data)
  end

  # Look in the pages folder (Or we can create a manifest of allowed orgs)
  # if there is an organization that matches the name
  # build an instance of that sub org
  # otherwise build a generic Org
  def self.build_custom_org(name:, data:)
    if Org.manifest.include?(name.downcase)
      class_name = name
    else
      class_name = Org.default_org
    end

    class_name = Util.classify(class_name)
    klass = Object.const_get(class_name)

    klass.new(data)
  end

  def self.validate(data)
    all_valid = conditions.all? do |condition|
      condition.call
    end

    raise ValidationError.new unless all_valid
  end
end