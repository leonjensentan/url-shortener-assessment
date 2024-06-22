# spec/factories/visits.rb
FactoryBot.define do
    factory :visit do
      association :url #Ensure that each Visit record is associated with a Url record
      originating_geolocation { "Kuala Lumpur, Malaysia" }  #Set a default value for the originating_geolocation attribute
    end
  end