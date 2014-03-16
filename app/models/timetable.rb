class Timetable < ActiveRecord::Base
  has_many :routes
  validates :start, presence: true
  validates :name, presence: true
end
