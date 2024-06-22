# spec/models/visit_spec.rb
require 'rails_helper'

RSpec.describe Visit, type: :model do
  #Test that a Visit with valid attributes is valid
  it "is valid with valid attributes" do
    expect(build(:visit)).to be_valid
  end

  #Test that a Visit without a URL association is not valid
  it "is not valid without a url" do
    expect(build(:visit, url: nil)).not_to be_valid
  end

end