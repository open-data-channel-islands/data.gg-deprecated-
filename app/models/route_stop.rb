class RouteStop < ActiveRecord::Base
  belongs_to :stop
  belongs_to :route
  
  validates :idx, presence: true
  validates :stop_id, presence: true
  validates :route_id, presence: true
end
