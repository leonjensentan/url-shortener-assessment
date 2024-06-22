# spec/factories/urls.rb
FactoryBot.define do
    factory :url do
      target_url { "https://example.com" } #Set a default value for the target_url attribute
      short_url { SecureRandom.hex(3)[0, 15] } #Generate a unique short_url using SecureRandom.hex, limited to 15 characters
      title_tag { "Example Title" } #Set a default value for the title_tag attribute
      clicks { 0 } #Set a default value for the clicks attribute
    end
  end