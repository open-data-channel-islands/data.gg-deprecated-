class StopTimeException < ActiveRecord::Base
  has_and_belongs_to_many :stop_links
end
