class StopLink < ActiveRecord::Base
  belongs_to :route_stop
  belongs_to :origin_stop_link, class_name: "StopLink"
  has_many :stop_links, foreign_key: "origin_stop_link", class_name: "StopLink"
  validates :depart, presence: true
end
