class Route < ActiveRecord::Base
  has_many :route_stops, :order => "idx ASC", :dependent => :delete_all
  has_many :stop_times, :dependent => :delete_all
  belongs_to :timetable
  
  validates :name, presence: true
  validates :description, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true
end