
# look at ActiveRecord basics for a model:
# https://guides.rubyonrails.org/active_record_basics.html
module SomeExample
  class Record < ApplicationRecord
    has_many :favorites
    accepts_nested_attributes_for :favorites

    # we'll assume we've created a DB with
    # :name (String), :birthdate (DateTime), :gender (String)
  end
end
