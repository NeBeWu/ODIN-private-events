class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  validates :price, numericality: { greater_than_or_equal_to: 0, less_than: 10_000 }
end
