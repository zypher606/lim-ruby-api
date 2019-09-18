class Webpage < ApplicationRecord
    # model association
  has_many :contents, dependent: :destroy

  # validations
  validates_presence_of :url
end
