class StopTime < ActiveRecord::Base
  belongs_to :route_stop
  belongs_to :route
  belongs_to :origin_stop_time, class_name: "StopTime"
  has_many :stop_times, dependent: :delete_all, foreign_key: "origin_stop_time_id", class_name: "StopTime"
  has_and_belongs_to_many :stop_time_exceptions, join_table: :stop_time_exceptions_stop_times
  validates :time, presence: true
  validates :route_id, presence: true
  
  default_scope joins(:route_stop).order('stop_times.origin_stop_time_id ASC, route_stops.idx ASC') # always order by the indexing of the route_stop entries
  
  def time_string
    time_s = time.to_s
    
    if time >= 0
      if time < 10
        time_s = "000" + time_s
      elsif time < 100
        time_s = "00" + time_s
      end
    end
    
    minute = time_s[time_s.length - 2, time_s.length - 1]
    if time_s.length == 3
      hour = time_s[0, 1]
    else
      hour = time_s[0, 2]
    end
    
    return hour + ':' + minute
  end
end
