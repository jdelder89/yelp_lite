class Restaurant < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  # Direct associations

  has_many   :viewers,
             :dependent => :destroy

  # Indirect associations

  # Validations

end
