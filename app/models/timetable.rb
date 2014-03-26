class Timetable < ActiveRecord::Base
  has_many :routes
  has_many :stops
  validates :start, presence: true
  validates :name, presence: true
end
