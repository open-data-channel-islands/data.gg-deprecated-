class StopLink < ActiveRecord::Base
  has_one :route_stop
  has_one :origin_stop_link, class_name: "StopLink", foreign_key: "stop_link_id"

  validates :stop, presence: true
  validates :display, presence: true
  validates :skip, presence: true
  validates :arrive, presence: true
  validates :depart, presence: true
end
