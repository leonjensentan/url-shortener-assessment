class Url < ApplicationRecord
  
    #Validates the presence, length, and uniqueness of the short URL
    #Only validates uniqueness on creation to avoid issues with updates
    validates :short_url, presence: true, length: { maximum: 15 }, uniqueness: true, on: :create
  
    #Validates the presence and format of the target URL
    #Ensures the target URL follows the HTTP or HTTPS format
    validates :target_url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  
    #Validates the presence of the title tag
    #This ensures the title tag is fetched and stored
    validates :title_tag, presence: true
  
    #Validates the presence and numericality of the clicks
    #Ensures clicks are a non-negative integer
    validates :clicks, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
    #Association with the Visit model
    #A URL can have many associated visits
    has_many :visits
  end