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

      desired_location: user_data["desired_location"],

      gender: parse_gender(user_data["gender"]),
      hispanic_latino: user_data["hispanic_latino"],
      veteran_status: user_data["veteran_status"],
      disability_status: user_data["disability_status"],

      linkedin_link: linkify(user_data["linkedin_username"], :li),
      github_link: linkify(user_data["github_username"], :gh),
      personal_link: user_data["personal_link"],

      resume_path: parse_path(user_data["resume_path"]),
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

  # We'd probablty store these as enums
  # in the db not strings
  def self.parse_gender(gender_str)
    # case gender_str
    # when 'M'
    #   'Male'
    # when 'F'
    #   'Female'
    # else
    #   nil
    # end
    gender_str
  end

  def self.parse_dob(dob_string)
    # Something has to happen here right
    # Date.new(dob_string)
  end

  def self.parse_path(path)
    # Does some validation as well I guess
    if File.file?(path)
      File.expand_path(path)
    else
      nil
    end
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