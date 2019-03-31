class Evernote < Org
  def org_custom_fields
    # no-op
    # The organization subclass handles any elements of the application that are specific to it's webpage/process.
  end
end