class DataPathResolver
  
  def self.root(writable_path)
    if writable_path
      root = Rails.public_path.join('data')
    
      if !File.directory?(root)
        FileUtils::mkdir_p root
      end
      
      return root
    else
      return Rails.public_path.join('data')
    end
  end
  
  def self.transport_path(writable_path)
    transport = File.join(self.root(writable_path), "transport")
    
    if !public
      if !File.directory?(writable_path)
        FileUtils::mkdir_p transport
      end
    end
    
    return transport
  end
  
  def self.buses_path(writable_path)
    buses = File.join(self.transport_path(writable_path), "buses")
    
    if writable_path
      if !File.directory?(buses)
        FileUtils::mkdir_p buses
      end
    end
    
    return buses
  end
end