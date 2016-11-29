class City < ApplicationRecord
  # Direct associations

  has_many   :neighborhoods,
             :dependent => :destroy

  belongs_to :state

  # Indirect associations

  # Validations

end
