class StopLink < ActiveRecord::Base
  belongs_to :route_stop
  belongs_to :route
  belongs_to :origin_stop_link, class_name: "StopLink"
  has_many :stop_links, foreign_key: "origin_stop_link", class_name: "StopLink"
  validates :time, presence: true
  validates :route_id, presence: true
  
  def time_string
    time_s = time.to_s
    minute = time_s[time_s.length - 2, time_s.length - 1]
    if time_s.length == 3
      hour = time_s[0, 1]
    else
      hour = time_s[0, 2]
    end
    
    return hour + ':' + minute
  end
end
