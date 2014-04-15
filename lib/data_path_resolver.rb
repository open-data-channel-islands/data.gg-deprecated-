class DataPathResolver
  
  def self.root
    root = './public/data/'
    if !File.directory?(root)
      FileUtils::mkdir_p root
    end
    
    return root
  end
  
  def self.transport_path
    transport = File.join(self.root, "transport")
    if !File.directory?(transport)
      FileUtils::mkdir_p transport
    end
    
    return transport
  end
  
  def self.buses_path
    buses = File.join(self.transport_path, "buses")
    if !File.directory?(buses)
      FileUtils::mkdir_p buses
    end
    
    return buses
  end
  
end