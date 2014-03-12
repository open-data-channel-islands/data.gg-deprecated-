class RoutePeriod < ActiveRecord::Base
  belongs_to :route_overview
  
  validates :name, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true
end
