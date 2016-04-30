class Charts::HealthController < ApplicationController
  def totals
    @title = 'Chest and Heart Totals'
    totals_json = File.read("storage/#{ENV['place_code']}/health/chest_and_heart_totals.json")
    totals = JSON.parse(totals_json)

    @labels = []

    age_25_34 = []
    age_35_44 = []
    age_45_54 = []
    age_55_64 = []
    age_65_69 = []
    age_70_75 = []

    totals.sort_by{ |p| p["Year"] }.each do |val|
      @labels << val["Year"].to_s
      age_25_34 << val["Age 25-34"]
      age_35_44 << val["Age 35-44"]
      age_45_54 << val["Age 45-54"]
      age_55_64 << val["Age 55-64"]
      age_65_69 << val["Age 65-69"]
      age_70_75 << val["Age 70-75"]
    end

    @data = []
    @data << { name: "Age 25-34", data: age_25_34 }
    @data << { name: "Age 35-44", data: age_35_44 }
    @data << { name: "Age 45-54", data: age_45_54 }
    @data << { name: "Age 55-64", data: age_55_64 }
    @data << { name: "Age 65-69", data: age_65_69 }
    @data << { name: "Age 70-75", data: age_70_75 }
  end

  def new
    @title = 'Chest and Heart New Clients'
    totals_json = File.read("storage/#{ENV['place_code']}/health/chest_and_heart_totals.json")
    totals = JSON.parse(totals_json)

    @labels = []
    @data = []

    totals.sort_by{ |p| p["Year"] }.each do |val|
      @labels << val["Year"].to_s
      @data << val["New clients"]
    end
  end

  def concerns
    @title = 'Chest and Heart Concerns'
    concerns_json = File.read("storage/#{ENV['place_code']}/health/chest_and_heart_concerns.json")
    concerns = JSON.parse(concerns_json)

    body_mass_index_greater_or_equal_to_30 = []
    diabetes_found_in_screening = []
    raised_blood_pressure = []
    raised_cholesterol = []
    abnormal_ecg = []
    visceral_fat_greater_than_13 = []

    @labels = []

    concerns.sort_by{ |p| p["Year"] }.each do |val|
      @labels << val["Year"].to_s

      year_total = val["All screenings"].to_f

      body_mass_index_greater_or_equal_to_30 << (((val["Body Mass Index greater or equal to 30"].to_f || 0) / year_total) * 100).round(2)
      diabetes_found_in_screening << (((val["Diabetes found in screening"].to_f || 0) / year_total) * 100).round(2)
      raised_blood_pressure << (((val["Raised Blood Pressure"].to_f || 0) / year_total) * 100).round(2)
      raised_cholesterol << (((val["Raised Cholesterol"].to_f || 0) / year_total) * 100).round(2)
      abnormal_ecg << (((val["Abnormal ECG"].to_f || 0) / year_total) * 100).round(2)
      visceral_fat_greater_than_13 << (((val["Visceral Fat greater than 13"].to_f || 0) / year_total) * 100).round(2)
    end


    @data = []
    @data << { name: 'Body Mass Index greater or equal to 30', data: body_mass_index_greater_or_equal_to_30 }
    @data << { name: 'Diabetes found in screening', data: diabetes_found_in_screening }
    @data << { name: 'Raised Blood Pressure', data: raised_blood_pressure }
    @data << { name: 'Raised Cholesterol', data: raised_cholesterol }
    @data << { name: 'Abnormal ECG', data: abnormal_ecg }
    @data << { name: 'Visceral Fat greater than 13', data: visceral_fat_greater_than_13 }
  end

  def med_unit_bed_days_five_yr_avg
    @title = 'Medical Unit Bed Days Five Year Average'
    med_unit_bed_days_five_yr_avg_json = File.read("storage/#{ENV['place_code']}/health/med_unit_bed_days_five_yr_avg.json")
    med_unit_bed_days_five_yr_avg = JSON.parse(med_unit_bed_days_five_yr_avg_json)

    @men = []
    @women = []
    med_unit_bed_days_five_yr_avg.select{ |u| u['Mean Period'] == '2010-2014' }.each do |val|

     val.each do |k,v|
      next if k == 'Sex' || k == 'Mean Period'
        if val['Sex'] == 'Male (days)'
           @men << [ k, v ]
        else
          @women << [ k, v ]
        end
      end
    end

    respond_to do |format|
       format.html
    end
  end

end