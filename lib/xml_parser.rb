require 'nokogiri'
class XmlParser
    def self.get_object_xml(data)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.objects do # 'objects' is root
        process_array('object', data, xml) # 'object' is each element
      end
    end
    builder.to_xml
  end

  def self.process_array(label,array,xml)
    array.each do |hash|
      xml.send(label) do
        hash.each do |key,value|
          if value.is_a?(Array)
            process_array(key,value,xml)
          else
            key = key.gsub(' ', '-') # Replace spaces
            key = key.gsub('+', '-plus') # Replace +. I hate XML
            if key.count("0-9") > 0
              key = 'Key-' + key # XML can't have a number as the first letter
            end
            xml.send(key,value)
          end
        end
      end
    end
  end
end
