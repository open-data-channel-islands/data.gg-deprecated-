require 'json'

class Charts::EarningsController < ApplicationController


  def nominal_sex
    @title = 'Nominal Sex'
    earnings_json = File.read("storage/earnings_sex.json")
    earnings_sex = JSON.parse(earnings_json)
    earnings_sex.sort_by! { |c| c['Year'] }

    @labels = earnings_sex.uniq { |p| p['Year'] }.collect { |p| p['Year'] }
    @males = earnings_sex.select { |p| p['Sex'] == 'Male' }.collect{ |p| p['Nominal median earnings'] }
    @females = earnings_sex.select { |p| p['Sex'] == 'Female' }.collect{ |p| p['Nominal median earnings'] }

    respond_to do |format|
      format.html
    end
  end

  def age_group
    @title = 'Age Group 2014'
    earnings_json = File.read("storage/earnings_age_group.json")
    earnings_age_group = JSON.parse(earnings_json)
    earnings_age_group.sort_by! { |c| c['Year'] }

    @labels = earnings_age_group.select { |p| p['Year'] == 2014 }.collect { |p| p['Age Group'] }
    @lowers = earnings_age_group.select { |p| p['Year'] == 2014 }.collect{ |p| p['Lower quartile earnings'] }
    @medians = earnings_age_group.select { |p| p['Year'] == 2014 }.collect{ |p| p['Median earnings'] }
    @uppers = earnings_age_group.select { |p| p['Year'] == 2014 }.collect{ |p| p['Upper quartile earnings'] }

    respond_to do |format|
      format.html
    end
  end

    def sector
    @title = 'Sector 2014'
    earnings_json = File.read("storage/earnings_sector.json")
    earnings_sector = JSON.parse(earnings_json)
    earnings_sector.sort_by! { |c| [c['Year'], c['Median earnings']] }

    @labels = earnings_sector.select { |p| p['Year'] == 2014 }.collect { |p| p['Sector'] }
    @medians = earnings_sector.select { |p| p['Year'] == 2014 }.collect{ |p| p['Median earnings'] }

    respond_to do |format|
      format.html
    end
  end


end