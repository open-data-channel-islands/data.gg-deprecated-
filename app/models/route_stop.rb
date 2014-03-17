class RouteStop < ActiveRecord::Base
  belongs_to :stop
  belongs_to :route
  
  validates :idx, presence: true
  validates :stop, presence: true
  validates :route, presence: true
end
