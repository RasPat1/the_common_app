class Evernote < Org
  def org_custom_fields
    # no-op
    # The organization subclass handles any elements of the application that are specific to it's webpage/process.
    [
      {
        type: 'text_field',
        id: 'job_application_answers_attributes_0_text_value',
        preferred_finder_name: 'id',
        user_field_name: :linkedin_link,
        mutate_keyword: :set,
      },
      {
        type: 'text_field',
        id: 'job_application_answers_attributes_1_text_value',
        preferred_finder_name: 'id',
        user_field_name: :website,
        mutate_keyword: :set,
      },
      {
        type: 'text_field',
        id: 'job_application_answers_attributes_2_text_value',
        preferred_finder_name: 'id',
        user_field_name: :how_did_you_hear,
        mutate_keyword: :set,
      },
    ]
  end
end