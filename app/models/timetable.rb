require './lib/data_path_resolver'

class Timetable < ActiveRecord::Base
  has_many :routes
  has_many :stops
  validates :start_date, presence: true
  validates :name, presence: true
  
  # Generates a path for a timetable
  def self.filename(date, version, type, zipped)
    if !type.match("^/\./")
      type = '.' + type
    end
    
    filename = date + '_' + version + type
    if zipped
      filename = filename + '.tar.gz'
    end
    
    return File.join(DataPathResolver.buses_path(false), filename)
  end

  
  def filename(type)
    if !type.match("^/\./")
      type = '.' + type
    end
    
    name = start_date.strftime('%Y-%m-%d') + '_' + current_version.to_s + type
    return File.join(DataPathResolver.buses_path(true), name) # should be writeable as that's what this is used for
  end
end
