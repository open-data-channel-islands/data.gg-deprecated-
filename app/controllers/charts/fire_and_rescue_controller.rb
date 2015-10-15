class Charts::FireAndRescueController < ApplicationController
  def attendances
    @title = 'Attendances'
    attendances_json = File.read("storage/#{ENV['place_code']}/fire_and_rescue/attendances.json")
    attendances = JSON.parse(attendances_json)

    @labels = []
    @fires =[]
    @fire_chimney = []
    @false_alarms = []
    @false_alarms_malicious = []
    @special_emergency = []
    @special_non_emergency = []
    @special_road = []
    @special_general = []

    attendances.sort_by{ |p| p['Year'] }.each do |val|
      @labels << val['Year'].to_s
      @fires << val['All other types of fires']
      @fire_chimney << val['Chimney fires']
      @false_alarms << val['False alarms general']
      @false_alarms_malicious << val['False alarms malicious']
      @special_emergency << val['Special service emergency']
      @special_non_emergency << val['Special service non-emergency']
      @special_road << val['Special service Road Traffic Collisions']
      @special_general << val['Special service General']
    end
  end
end
