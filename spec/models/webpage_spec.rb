require 'rails_helper'

RSpec.describe Webpage, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Content model
  it { should have_many(:contents).dependent(:destroy) }
  # Validation tests
  # ensure column url is present before saving
  it { should validate_presence_of(:url) }

end
