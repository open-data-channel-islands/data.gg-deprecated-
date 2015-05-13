class Charts::SailingsController < ApplicationController
  def condor_punctuality
    @title = 'Condor Punctuality'

    punctuality_json = File.read("storage/sailings/condor_punctuality.json")
    punctuality = JSON.parse(punctuality_json)
    punctuality.sort_by! { |c| [ c['year'].to_i, c['quarter'].to_i ] }

    @clipper = []
    @north = []
    @south = []
    quarter_finder = punctuality.map {|c| [c['year'],c['quarter']] }.uniq
    quarter_finder.each do |qtr|
      punctuality.each do |p|
        if p['year'] == qtr[0] && p['quarter'] == qtr[1]
          if p['route'] == 'Conventional'
            @clipper << p['ontimepc']
          elsif p['route'] == 'Northern Route'
            @north << p['ontimepc']
          elsif p['route'] == 'Southern Route'
            @south << p['ontimepc']
          end
        end
      end
    end

    @labels = punctuality.map {|c| "#{c['year']} Q#{c['quarter']}" }.uniq

    respond_to do |format|
      format.html
    end




  end
end
