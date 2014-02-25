class StopLink < ActiveRecord::Base

  validates :stop, presence: true
  validates :display, presence: true
  validates :skip, presence: true
  validates :arrive, presence: true
  validates :depart, presence: true
end
