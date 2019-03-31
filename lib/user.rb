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
    :linkedin_link,
    :github_link,
    :personal_link,
    :resume_path,
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
      linkedin_link:,
      github_link:,
      personal_link:,
      resume_path:,
      address:
    )
    @first_name = first_name
    @last_name = last_name
    @phone = phone
    @email = email

    @gender = gender
    @hispanic_latino = hispanic_latino
    @veteran_status = veteran_status
    @disability_status = disability_status

    @linkedin_link = linkedin_link
    @github_link = github_link
    @personal_link = personal_link

    @resume_path = resume_path

    @address = address
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