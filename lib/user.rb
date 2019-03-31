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
    :address,

    # Custom Answers
    :website,
    :how_did_you_hear

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

    @linkedin_link = linkedin_link
    @github_link = github_link
    @personal_link = personal_link
  end

  # sometimes they ask for a website.
  # Let's say we want personal website first but if that's
  # not available we'll back up to our github
  def website
    personal_link || github_link || linkedin_link
  end

  # I imagine we'd have a number of custom answers to questions like these and we could use an interesting and flexible data model to keep track of and generate them
  def how_did_you_hear
    'Internet search'
  end
end