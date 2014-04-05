class Stop < ActiveRecord::Base
  has_many :route_stops, :dependent => :delete_all
  belongs_to :timetable
  
  validates :name, presence: true
  validates :timetable, presence: true
end
