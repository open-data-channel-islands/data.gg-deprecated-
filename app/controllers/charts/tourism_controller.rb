class Charts::TourismController < ApplicationController
  def cruises
    @title = 'Cruises'
    cruises_json = File.read("storage/#{ENV['place_code']}/tourism/cruises.json")
    cruises = JSON.parse(cruises_json)

    @labels = []
    count_dict = {}

    cruises.each do |c|
      @labels << c['Date'][3..7].to_s
    end
    @labels.uniq!

    cruises.each do |val|
      label = val['Date'][3..7].to_s

      if count_dict[label].nil?
        count_dict[label] = val['No. of cruise passengers'].to_i
      else
        count_dict[label] += val['No. of cruise passengers'].to_i
      end
    end

    @count = []
    count_dict.keys.sort.each do |key|
      @count << count_dict[key]
    end


  end
end
