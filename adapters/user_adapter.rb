require_relative './adapter'
require_relative '../lib/user'

# Tightly coupled to YAML file
# Simply a transport object
class UserAdapter < Adapter
  def self.build_user(user_data, address)
    data = {
      first_name: user_data["first_name"],
      last_name: user_data["last_name"],
      dob: parse_dob(user_data["dob"]),
      phone: user_data["phone"],
      email: user_data["email"],

      gender: user_data["gender"],
      hispanic_latino: user_data["hispanic_latino"],
      veteran_status: user_data["veteran_status"],
      disability_status: user_data["disability_status"],

      resume_location: user_data["resume_location"],

      linkedin_link: linkify(user_data["linkedin_username"], :li),
      github_link: linkify(user_data["github_username"], :gh),
      personal_link: user_data["personal_link"],
    }

    validate(data)

    User.new(**data, address: address)
  end

  def self.linkify(path, type)
    case type
    when :li
      "https://www.linkedin.com/in/#{path}"
    when :gh
      "https://www.github.com/#{path}"
    end
  end

  def self.parse_dob(dob_string)
    # Something has to happen here right
    # Date.new(dob_string)
  end

  def self.validate(data)
    all_valid = conditions.all? do |condition|
      condition.call
    end

    raise ValidationError.new unless all_valid
  end

  # one of the conditions is that it uses all the required fields
  def required_fields
  end
end