class Restaurant < ApplicationRecord
  # Direct associations

  has_many   :viewers,
             :dependent => :destroy

  # Indirect associations

  # Validations

end
