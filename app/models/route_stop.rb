class RouteStop < ActiveRecord::Base
  belongs_to :stop
  belongs_to :route
  has_many :stop_times, :dependent => :delete_all
  default_scope :order => 'idx ASC'
  
  validates :idx, presence: true
  validates :stop_id, presence: true
  validates :route_id, presence: true
end
