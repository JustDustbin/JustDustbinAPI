class Dustbin < ActiveRecord::Base
  acts_as_paranoid
  validates :name, presence: true, length: { minimum: 1, maximum: 40 }
  validates :worker, presence: true, length: { minimum: 1, maximum: 40 }
  validates :city, presence: true, length: { minimum: 1, maximum: 40 }
  validates :support_number, phone: { types: [:mobile] }, presence: true
  validates :status, numericality: { only_integer: true, less_than_or_equal_to: 100, greater_than_or_equal_to: 0 }, presence: true
  validates :gps_latitude, presence: true
  validates :gps_longitude, presence: true
  validates :unique_id, presence: true, numericality: true
end