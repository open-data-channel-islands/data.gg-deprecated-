class Route < ActiveRecord::Base
  has_many :stops
  has_many :route_stops
end
