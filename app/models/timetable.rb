class Timetable < ActiveRecord::Base
  has_many :route_overviews
  validates :effective_date, presence: true
  validates :name, presence: true
end
