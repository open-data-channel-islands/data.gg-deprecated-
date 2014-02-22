class RouteStop < ActiveRecord::Base
  belongs_to :stop
  belongs_to :route
  
  validates :index, presence: true
end
