class Timetable < ActiveRecord::Base
  has_many :routes
  has_many :stops
  validates :start, presence: true
  validates :name, presence: true
  
  
  def filename(type)
    if !type.start_with('.')?
      type = '.' + type
    end
    
    start + '_' + current_version + type
  end
end
