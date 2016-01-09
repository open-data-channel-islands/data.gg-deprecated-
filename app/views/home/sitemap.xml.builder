xml.instruct!
xml.urlset xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.url do
    xml.loc "#{root_url}"
    xml.changefreq 'weekly'
  end
  xml.url do
    xml.loc "#{root_url}charts"
    xml.changefreq 'weekly'
  end
  xml.url do
    xml.loc "#{root_url}developers"
    xml.changefreq 'weekly'
  end
  xml.url do
    xml.loc "#{root_url}research_development"
    xml.changefreq 'weekly'
  end
  xml.url do
    xml.loc "#{root_url}apps"
    xml.changefreq 'weekly'
  end
  xml.url do
    xml.loc "#{root_url}about"
    xml.changefreq 'weekly'
  end
  xml.url do
    xml.loc "#{root_url}donate"
    xml.changefreq 'weekly'
  end
  xml.url do
    xml.loc "#{root_url}contribute"
    xml.changefreq 'weekly'
  end
  xml.url do
    xml.loc "#{root_url}help"
    xml.changefreq 'weekly'
  end

  @data_categories.each do |data_category|
    xml.url do
      xml.loc "#{root_url}developers/#{data_category.stub}"
      xml.changefreq 'weekly'
    end

    xml.url do
      xml.loc "#{root_url}charts/#{data_category.stub}"
      xml.changefreq 'weekly'
    end
  end
  @data_sets.each do |data_set|
    xml.url do
      xml.loc "#{root_url}developers/#{data_set.data_category.stub}/#{data_set.stub}.json"
      xml.lastmod data_set.get_data_updated.strftime("%Y-%m-%dT%H:%M%:z")
      xml.changefreq 'weekly'
    end
    xml.url do
      xml.loc "#{root_url}developers/#{data_set.data_category.stub}/#{data_set.stub}.xml"
      xml.lastmod data_set.get_data_updated.strftime("%Y-%m-%dT%H:%M%:z")
      xml.changefreq 'weekly'
    end
    xml.url do
      xml.loc "#{root_url}developers/#{data_set.data_category.stub}/#{data_set.stub}.html"
      xml.lastmod data_set.get_data_updated.strftime("%Y-%m-%dT%H:%M%:z")
      xml.changefreq 'weekly'
    end
    xml.url do
      xml.loc "#{root_url}developers/#{data_set.data_category.stub}/#{data_set.stub}.html?layout=false"
      xml.lastmod data_set.get_data_updated.strftime("%Y-%m-%dT%H:%M%:z")
      xml.changefreq 'weekly'
    end
  end

  # TODO: Find better way of doing charts
  ['buses', 'buses/usage', 'buses/split', 'housing', 'housing/mean_average', 'housing/transactions', 'housing/bedrooms', 'housing/types', 'housing/units',
    'crime', 'crime/detected', 'crime/reported', 'crime/prison_population', 'crime/worried', 'traffic', 'traffic/classifications', 'traffic/collisions',
    'traffic/offences', 'population', 'population/male_vs_female', 'population/parish', 'education', 'education/post16results',
    'education/post16results_btec', 'education/gcses_overall', 'education/gcses_by_school', 'education/students_in_uk', 'earnings', 'earnings/nominal_sex',
    'earnings/age_group', 'earnings/sector', 'inflation', 'inflation/changes', 'inflation/rpi_group_changes', 'water', 'water/domestic_consumption',
    'emissions', 'emissions/types', 'employment', 'employment/totals', 'sailings', 'sailings/condor_punctuality', 'weather', 'weather/totals',
    'weather/frost_days', 'finance', 'finance/deposits', 'finance/licences', 'health', 'health/concerns', 'health/totals', 'health/new',
    'health/med_unit_bed_days_five_yr_avg', 'fire_and_rescue', 'fire_and_rescue/attendances', 'overseas_aid', 'overseas_aid/contributions', 'tourism',
    'tourism/cruises', 'tourism/air_vs_sea_ann', 'energy', 'energy/electricity_consumption', 'energy/electricity_import_vs_generated', 'transport',
    'transport/registered_vehicles', 'tides', 'fuel', 'sports', 'broadband', 'recycling', 'roadworks', 'fishing'].each do |chart|
      xml.url do
        xml.loc "#{root_url}charts/#{chart}"
        xml.changefreq 'weekly'
      end
    end
  end
