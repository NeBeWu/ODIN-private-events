class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :attendances, foreign_key: 'attended_event_id', inverse_of: 'attended_event', dependent: :destroy
  has_many :attendees, through: :attendances

  has_many :invitations, foreign_key: 'invited_event_id', inverse_of: 'invited_event', dependent: :destroy
  has_many :invitees, through: :invitations

  validates :price, numericality: { greater_than_or_equal_to: 0, less_than: 10_000 }

  scope :previous, -> { where('date <= ?', Time.now).order(date: :desc) }
  scope :upcoming, -> { where('date >= ?', Time.now).order(date: :asc) }
  scope :public?, -> { where('private = ?', false) }
end
