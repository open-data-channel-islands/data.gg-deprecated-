require './lib/data_path_resolver'

class Timetable < ActiveRecord::Base
  has_many :routes
  has_many :stops
  validates :start_date, presence: true
  validates :name, presence: true
  
  attr_accessor :root_url
  
  def xml_download_url_compressed
    return File.join(DataPathResolver.public_buses_path(root_url), filename('.xml.tar.gz'))
  end
  
  def json_download_url_compressed
    return File.join(DataPathResolver.public_buses_path(root_url), filename('.json.tar.gz'))
  end
  
  def xml_download_url
    return File.join(DataPathResolver.public_buses_path(root_url), filename('.xml'))
  end
  
  def json_download_url
    return File.join(DataPathResolver.public_buses_path(root_url), filename('.json'))
  end
  
  # Generates a path for a timetable
  def self.filepath(date, version, type, zipped)
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
    name = start_date.strftime('%Y-%m-%d') + '_' + current_version.to_s + type
    return name
  end

  
  def filepath(type)
    if !type.match("^/\./")
      type = '.' + type
    end
    
    
    return File.join(DataPathResolver.buses_path(true), name) # should be writeable as that's what this is used for
  end
end
