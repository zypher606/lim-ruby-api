class Content < ApplicationRecord
  belongs_to :webpage

  validates_presence_of :content_type, :content_value
end
