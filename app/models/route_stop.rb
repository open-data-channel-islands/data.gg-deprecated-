class RouteStop < ActiveRecord::Base
  belongs_to :stop
  belongs_to :route
  has_many :stop_links, :dependent => :delete_all
  
  validates :idx, presence: true
  validates :stop_id, presence: true
  validates :route_id, presence: true
end
