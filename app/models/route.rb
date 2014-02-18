class Route < ActiveRecord::Base
  has_many :stops
  has_many :route_stops
  belongs_to :timetable
  
  validates :name, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true
  
  
end
