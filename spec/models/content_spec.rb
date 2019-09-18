require 'rails_helper'

RSpec.describe Content, type: :model do
  # Association test
  # ensure an item record belongs to a single webpage record
  it { should belong_to(:webpage) }
  # Validation test
  # ensure column content_type and content_value are present before saving
  it { should validate_presence_of(:content_type) }
  it { should validate_presence_of(:content_value) }

end
