require_relative '../lib/user.rb'

RSpec.describe User do
  context "boots properly" do
    it "can create a new user" do
      User.new
    end

    it "has a file path" do
      expect(User::FILE_PATH).not_to be_nil
    end

    it "can load the file path" do

    end
  end
end