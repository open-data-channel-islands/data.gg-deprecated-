class RouteOverview < ActiveRecord::Base
  has_many :route_periods
  belongs_to :timetable
  
  validates :name, presence: true
end
