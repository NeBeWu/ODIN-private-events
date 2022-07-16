class User < ApplicationRecord
  has_many :created_events, class_name: 'Event', foreign_key: 'creator_id', dependent: :destroy

  has_many :attendances, foreign_key: 'attendee_id', inverse_of: 'attendee'
  has_many :attended_events, through: :attendances

  has_many :invitations, foreign_key: 'invitee_id', inverse_of: 'invitee'
  has_many :invited_events, through: :invitations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
