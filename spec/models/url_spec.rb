# spec/models/url_spec.rb
require 'rails_helper'

RSpec.describe Url, type: :model do
  #Test that a Url with valid attributes is valid
  it "is valid with valid attributes" do
    expect(build(:url)).to be_valid
  end

  #Test that a Url without a target_url is not valid
  it "is not valid without a target_url" do
    expect(build(:url, target_url: nil)).not_to be_valid
  end

  #Test that a Url with an invalid target_url format is not valid
  it "is not valid with an invalid target_url" do
    expect(build(:url, target_url: "invalid_url")).not_to be_valid
  end

  #Test that a Url without a short_url is not valid
  it "is not valid without a short_url" do
    expect(build(:url, short_url: nil)).not_to be_valid
  end

  it "is not valid without clicks" do
    expect(build(:url, clicks: nil)).not_to be_valid
  end

  #Test that a Url with a short_url longer than 15 characters is not valid
  it "is not valid with a short_url longer than 15 characters" do
    expect(build(:url, short_url: "a" * 16)).not_to be_valid
  end

  #Test that a Url with a non-unique short_url is not valid
  it "is not valid with a non-unique short_url" do
    create(:url, short_url: "short")
    expect(build(:url, short_url: "short")).not_to be_valid
  end
end