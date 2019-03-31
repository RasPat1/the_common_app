# This adapts the data in the user object to the format
# that the strategy requires
# So imagine we're selecting a value form a dropdown on a page using the greenhouse strategy. The dropdown asks about veteran status
# the user object has a true/false/nil value for verteran status
# which corresponds to yes i am a veteran no I am not and decline to answer roughly
# we take it in from our data source whether that's yml or user input on terminal or web app form fields or whatever. We modify it a standardized format that goes into our db. (t/f/nil probably or enums depending on what it is)
# now when we need to execute a strategy for that user we want to make sure that false maps to the string "I am not a protected veteran" or option 1 for greenhouse. Another strategy may have a different order or list options and different text. So this adapter fills in the actual dat value in our system with whatever the fuck text and matching criteria a strategy may require.  For custom fields with an org this mapping may need to be done also.  SO we might be able to get away with putting this in the strategy at some point. But let's break it out here and see how we feel.

class GreenhouseAdapter
  def initialize
  end

  def bind(user:)
    @user = user
  end

  # If the adapter has a method for it use that
  # otherwise delegate the field over to the user
  # and directly access that shit.
  def fetch(data_field)
    data = @user.send(data_field)

    # Adapt the user data for this specific strategy
    if modified_data_fields.include?(data_field)
      data = self.send(data_field, data)
    end

    data
  end

  # Each of these should have a custom method to
  # get the correct selector string
  def modified_data_fields
    [:gender, :hispanic_latino, :veteran_status, :disability_status]
  end

  def gender(str)
    case str
    when 'M'
      'Male'
    when 'F'
      'Female'
    end
  end

  def hispanic_latino(bool)
    case bool
    when true
      'Yes'
    when false
      'No'
    when nil
      'Decline To Self Identify'
    end
  end

  def veteran_status(bool)
    case bool
    when true
      'I identify as one or more of the classifications of a protected veteran'
    when false
      'I am not a protected veteran'
    when nil
      'I don\'t wish to answer'
    end
  end

  def disability_status(bool)
    case bool
    when true
      'Yes, I have a disability (or previously had a disability)'
    when false
      'No, I don\'t have a disability'
    when nil
      'I don\'t wish to answer'
    end
  end

  # def method_missing
  # end

  # def veteran_status
  # end
end