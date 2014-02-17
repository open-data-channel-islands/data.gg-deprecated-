class Timetable < ActiveRecord::Base
  has_many :routes
  validates :effective_date, presence: true
  validates :name, presence: true
end
