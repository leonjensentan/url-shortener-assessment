class Visit < ApplicationRecord
    #Association with the Url model
    #A visit belongs to a specific URL
    belongs_to :url
end
