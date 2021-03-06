class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :consultations_as_asker, source: :consultations, foreign_key: :asker_id
  has_many :consultations_as_mentor, source: :consultations, foreign_key: :mentor_id
  has_many :messages
  has_many :chatrooms, through: :messages
  has_one_attached :photo

  def average_rating

  end
end
