class Url < ApplicationRecord
    validates :short_url, presence: true, length: { maximum: 15 }, uniqueness: true, on: :create
    validates :target_url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
    validates :title_tag, presence: true
    validates :clicks, presence: true, numericality: { greater_than_or_equal_to: 0 }
    has_many :visits
end
