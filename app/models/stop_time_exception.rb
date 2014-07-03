class StopTimeException < ActiveRecord::Base
  has_and_belongs_to_many :stop_times, join_table: :stop_time_exceptions_stop_times
  belongs_to :timetable
  
  validates :name, presence: true
end
