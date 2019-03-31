require_relative './adapter'
require_relative '../lib/address.rb'

class AddressAdapter < Adapter
  def self.build_address(address_data)
    data = {
      address_no: address_data["address_no"],
      address_st: address_data["address_st"],
      address_city: address_data["address_city"],
      address_state: address_data["address_state"],
      address_zip: address_data["address_zip"],
    }

    validate(data)

    Address.new(data)
  end

  def self.validate(data)
    # idk make an api call to make sure it's real?
    valid = true

    raise ValidationError.new unless valid
  end
end