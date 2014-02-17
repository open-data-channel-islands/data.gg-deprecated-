class Stop < ActiveRecord::Base
  has_many :route_stops
  
  validates :name, presence: true
end
