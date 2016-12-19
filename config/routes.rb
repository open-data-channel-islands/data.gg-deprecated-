DataGg::Application.routes.draw do

  devise_for :users
  root 'home#index'

  get 'about' => 'home#about', as: :about
  get 'apps' => 'home#apps', as: :apps
  get 'help' => 'home#help', as: :help
  get 'contact' => 'home#contact', as: :contact
  get 'contribute' => 'home#contribute', as: :contribute
  get 'donate' => 'home#donate', as: :donate
  get 'research_development' => 'home#research_development'

  get 'bespoke/gp_flights_arrivals' => 'bespoke#gp_flights_arrivals'
  get 'bespoke/gp_flights_departures' => 'bespoke#gp_flights_departures'

  # New
  get 'developers/:data_category' => 'home#developers_data_category', as: :developers_data_category
  get 'api/1.1/:data_category/:data_set' => 'home#api', as: :api
  get 'sitemap' => 'home#sitemap'
  ###

get 'maps' => 'maps#guernsey', as: :maps
get 'maps/guernsey' => 'maps#guernsey', as: :maps_guernsey


  # Charts section
  get 'charts' => 'home#charts', as: :charts

  namespace :charts do
    get 'buses' => 'buses#usage', as: :buses
    get 'buses/usage' => 'buses#usage', as: :buses_usage
    get 'buses/split' => 'buses#split', as: :buses_split

    # Housing
    get 'housing' => 'housing#mean_average', as: :housing
    get 'housing/mean_average' => 'housing#mean_average', as: :housing_mean_average
    get 'housing/transactions' => 'housing#transactions', as: :housing_transactions
    get 'housing/bedrooms' => 'housing#bedrooms', as: :housing_bedrooms
    get 'housing/types' => 'housing#types', as: :housing_types
    get 'housing/units' => 'housing#units', as: :housing_units

    # Crime
    get 'crime' => 'crime#detected', as: :crime
    get 'crime/detected' => 'crime#detected', as: :crime_detected
    get 'crime/reported' => 'crime#reported', as: :crime_reported
    get 'crime/prison_population' => 'crime#prison_population'
    get 'crime/worried' => 'crime#worried'

    # Traffic
    get 'traffic' => 'traffic#classifications', as: :traffic
    get 'traffic/classifications' => 'traffic#classifications', as: :traffic_classifications
    get 'traffic/collisions' => 'traffic#collisions', as: :traffic_collisions
    get 'traffic/offences' => 'traffic#offences', as: :traffic_offences

    # Population
    get 'population' => 'population#male_vs_female', as: :population
    get 'population/male_vs_female' => 'population#male_vs_female', as: :population_male_vs_female
    get 'population/parish' => 'population#parish', as: :population_parish

    # Education
    get 'education' => 'education#post16results', as: :education
    get 'education/post16results', as: :education_post16results
    get 'education/post16results_btec', as: :education_post16results_btec
    get 'education/gcses_overall', as: :education_gcses_overall
    get 'education/gcses_by_school', as: :education_gcses_by_school
    get 'education/students_in_uk'

    get 'earnings' => 'earnings#nominal_sex', as: :earnings
    get 'earnings/nominal_sex' => 'earnings#nominal_sex', as: :earnings_nominal_sex
    get 'earnings/age_group' => 'earnings#age_group', as: :earnings_age_group
    get 'earnings/sector' => 'earnings#sector', as: :earnings_sector

    get 'inflation' => 'inflation#changes', as: :inflation
    get 'inflation/changes' => 'inflation#changes', as: :inflation_changes
    get 'inflation/rpi_group_changes' => 'inflation#rpi_group_changes', as: :inflation_rpi_group_changes

    # Water
    get 'water' => 'water#domestic_consumption'
    get 'water/domestic_consumption' => 'water#domestic_consumption'

    # Emissions
    get 'emissions' => 'emissions#types'
    get 'emissions/types' => 'emissions#types'
    get 'emissions/source' => 'emissions#source'

    # Employment
    get 'employment' => 'employment#totals'
    get 'employment/totals' => 'employment#totals'

    get 'sailings' => 'sailings#condor_punctuality'
    get 'sailings/condor_punctuality' => 'sailings#condor_punctuality'

    # Weather
    get 'weather' => 'weather#totals'
    get 'weather/totals' => 'weather#totals'
    get 'weather/frost_days'

    # Finance
    get 'finance' => 'finance#deposits'
    get 'finance/deposits' => 'finance#deposits'
    get 'finance/licences' => 'finance#licences'

    # Health
    get 'health' => 'health#concerns'
    get 'health/concerns' => 'health#concerns'
    get 'health/totals' => 'health#totals'
    get 'health/new' => 'health#new'
    get 'health/med_unit_bed_days_five_yr_avg'

    # Fire & Rescue
    get 'fire_and_rescue' => 'fire_and_rescue#attendances'
    get 'fire_and_rescue/attendances' => 'fire_and_rescue#attendances'

    # Overseas Aid
    get 'overseas_aid' => 'overseas_aid#contributions'
    get 'overseas_aid/contributions' => 'overseas_aid#contributions'

    # Tourism
    get 'tourism' => 'tourism#cruises'
    get 'tourism/cruises' => 'tourism#cruises'
    get 'tourism/air_vs_sea_ann' => 'tourism#air_vs_sea_ann'

    # Energy
    get 'energy' => 'energy#electricity_consumption'
    get 'energy/electricity_consumption' => 'energy#electricity_consumption'
    get 'energy/electricity_import_vs_generated' => 'energy#electricity_import_vs_generated'

    # Transport
    get 'transport' => 'transport#registered_vehicles'
    get 'transport/registered_vehicles' => 'transport#registered_vehicles'

    get 'government-spending' => 'government_spending#percent_treemap'
    get 'government-spending/percent-treemap' => 'government_spending#percent_treemap'
    get 'government-spending/slider' => 'government_spending#slider'
    get 'government-spending/bubble-tree' => 'government_spending#bubble_tree'

    # Tides
    get 'tides' => 'tides#index'
    # Fuel
    get 'fuel' => 'fuel#index'
    # Sports
    get 'sports' => 'sports#index'
    # Broadband
    get 'broadband' => 'broadband#index'
    # Recycling
    get 'recycling' => 'recycling#index'
    # Roadworks
    get 'roadworks' => 'roadworks#index'
    # Fishing
    get 'fishing' => 'fishing#index'

  end


  get 'developers' => 'home#developers', as: :developers


  # API calls

  namespace :api do
    namespace "v10", path: "1.0" do

      get 'buses/usage' => 'buses#usage'

      get 'crime/crimes' => 'crime#crimes'
      get 'crime/prison_population' => 'crime#prison_population'
      get 'crime/worried' => 'crime#worried'

      get 'traffic/traffic' => 'traffic#traffic'
      get 'traffic/collisions' => 'traffic#collisions'
      get 'traffic/injuries' => 'traffic#injuries'
      get 'traffic/classifications' => 'traffic#classifications'

      get 'housing/prices' => 'housing#local_prices'
      get 'housing/local_prices' => 'housing#local_prices'
      get 'housing/open_prices' => 'housing#open_prices'
      get 'housing/bedrooms' => 'housing#bedrooms'
      get 'housing/types' => 'housing#types'
      get 'housing/units' => 'housing#units'

      get 'flights/arrivals' => 'flights#arrivals'
      get 'flights/departures' => 'flights#departures'

      get 'sailings/harbour' => 'sailings#harbour'
      get 'sailings/condor_punctuality' => 'sailings#condor_punctuality'
      get 'sailings/cruises' => 'sailings#cruises'

      get 'education/post16results' => 'education#post16results'
      get 'education/gcse_overall' => 'education#gcse_overall'
      get 'education/gcse_school' => 'education#gcse_school'
      get 'education/students_in_uk' => 'education#students_in_uk'

      get 'population/population' => 'population#population'
      get 'population/age' => 'population#age'
      get 'population/age_male' => 'population#age_male'
      get 'population/age_female' => 'population#age_female'
      get 'population/birthplace' => 'population#birthplace'
      get 'population/changes' => 'population#changes'
      get 'population/district' => 'population#district'
      get 'population/parish' => 'population#parish'

      get 'earnings/earnings_age_group' => 'earnings#earnings_age_group'
      get 'earnings/earnings_sector' => 'earnings#earnings_sector'
      get 'earnings/earnings_sex' => 'earnings#earnings_sex'

      get 'inflation/changes' => 'inflation#changes'
      get 'inflation/rpi_group_changes' => 'inflation#rpi_group_changes'
      get 'inflation/rpix_group_changes' => 'inflation#rpix_group_changes'

      get 'government-spending/monetary-amount' => 'government_spending#monetary_amount'
      get 'government-spending/percentage' => 'government_spending#percentage'
      get 'government-spending/per-capita' => 'government_spending#per_capita'

      get 'water/domestic_consumption' => 'water#domestic_consumption'

      get 'emissions/types' => 'emissions#types'

      get 'employment/totals' => 'employment#totals'

      get 'weather/annual' => 'weather#annual'
      get 'weather/monthly' => 'weather#monthly'
      get 'weather/frost_days' => 'weather#frost_days'

      get 'finance/banking' => 'finance#banking'

      get 'health/concerns' => 'health#concerns'
      get 'health/totals' => 'health#totals'
      get 'health/med_unit_bed_days_five_yr_avg' => 'health#med_unit_bed_days_five_yr_avg'

      get 'fire_and_rescue/attendances' => 'fire_and_rescue#attendances'

      get 'overseas_aid/contributions' => 'overseas_aid#contributions'

      get 'tourism/cruises' => 'tourism#cruises'
      get 'tourism/air_by_month' => 'tourism#air_by_month'
      get 'tourism/sea_by_month' => 'tourism#sea_by_month'

      get 'energy/electricity_consumption' => 'energy#electricity_consumption'
      get 'energy/electricity_import_vs_generated' => 'energy#electricity_import_vs_generated'

      get 'transport/registered_vehicles' => 'transport#registered_vehicles'
    end
  end

  # LEGACY CALLS
  get 'api/v1/flights/arrivals', to: 'api/v10/flights#arrivals'
  get 'api/v1/flights/departures', to: 'api/v10/flights#departures'

  get 'api/v1/education/', to: 'api/v1/education#index'
  get 'api/v1/education/post16results', to: 'api/v1/education#post16results'
  get 'api/v1/education/gcse_overall', to: 'api/v1/education#gcse_overall'
  get 'api/v1/education/gcse_school', to: 'api/v1/education#gcse_school'

  get 'api/v1/population/', to: 'api/v1/population#index'
  get 'api/v1/population/population', to: 'api/v1/population#population'

  get 'api/v1/police/', to: 'api/v1/police#index'
  get 'api/v1/police/crimes', to: 'api/v1/police#crimes'
  get 'api/v1/police/traffic', to: 'api/v1/police#traffic'
  get 'api/v1/police/traffic_classifications', to: 'api/v1/police#traffic_classifications'
  get 'api/v1/police/traffic_collisions', to: 'api/v1/police#traffic_collisions'
  get 'api/v1/police/traffic_injuries', to: 'api/v1/police#traffic_injuries'

  get 'api/v1/earnings/', to: 'api/v1/earnings#index'
  get 'api/v1/earnings/earnings_age_group', to: 'api/v1/earnings#earnings_age_group'
  get 'api/v1/earnings/earnings_sector', to: 'api/v1/earnings#earnings_sector'
  get 'api/v1/earnings/earnings_sex', to: 'api/v1/earnings#earnings_sex'

  get 'api/v1/sailings/', to: 'api/v1/sailings#index'
  get 'api/v1/sailings/herm_trident', to: 'api/v1/sailings#herm_trident'
  get 'api/v1/sailings/harbour', to: 'api/v1/sailings#harbour'

end
