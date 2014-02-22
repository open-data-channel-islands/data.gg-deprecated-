class StopLink < ActiveRecord::Base
  belongs_to :route
  belongs_to :stop
  belongs_to :stop_link, foreign_key: "next_time_stop_link_id"
  belongs_to :stop_link, foreign_key: "next_place_stop_link_id"
  belongs_to :stop_link, foreign_key: "prev_time_stop_link_id"
  belongs_to :stop_link, foreign_key: "prev_place_stop_link_id"
  
  validates :time, presence: true
  validates :route, presence: true
  validates :stop, presence: true
  validates :display, presence: true
  validates :skip, presence: true
  validates :arrive, presence: true
  validates :depart, presence: true
end
