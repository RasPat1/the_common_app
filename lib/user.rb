
class User
  attr_reader :first_name,
    :last_name,
    :dob,
    :phone,
    :email,
    :gender,
    :hispanic_latino,
    :veteran_status,
    :disability_status,
    :resume_location,
    :linkedin_link,
    :github_link,
    :personal_link,
    :address

  def initialize(
      first_name:,
      last_name:,
      dob:,
      phone:,
      email:,
      gender:,
      hispanic_latino:,
      veteran_status:,
      disability_status:,
      resume_location:,
      linkedin_link:,
      github_link:,
      personal_link:,
      address:
    )
    @first_name = first_name
    @last_name = last_name
    @phone = phone
    @email = email
  end
end