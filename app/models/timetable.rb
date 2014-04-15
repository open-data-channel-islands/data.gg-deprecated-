require './lib/data_path_resolver'

class Timetable < ActiveRecord::Base
  has_many :routes
  has_many :stops
  validates :start, presence: true
  validates :name, presence: true
  
  
  def filename(type)
    if !type.match("^/\./")
      type = '.' + type
    end
    
    name = start.strftime('%Y-%m-%d') + '_' + current_version.to_s + type
    return File.join(DataPathResolver.buses_path, name)
  end
end
