class Route < ActiveRecord::Base
  has_many :route_stops, :dependent => :delete_all
  has_many :stop_links, :dependent => :delete_all
  belongs_to :timetable
  
  validates :name, presence: true
  validates :description, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true
end