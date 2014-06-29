module Api
  class Api::V10::Buses::TimetablesController < ApplicationController

    def list
      @timetables = Timetable.order(:start_date).all

      # Dirty hack, but the models have no idea about the HTTP context
      # so we need to hand it over before rendering the output
      root_url = "#{request.protocol}#{request.host_with_port}"
      @timetables.each do |t|
        t.root_url = root_url
      end

      respond_to do |format|
        format.xml { render :xml => @timetables.to_xml(methods: [:xml_download_url, :json_download_url, :xml_download_url_compressed, :json_download_url_compressed], except: [:created_at, :updated_at]) }
        format.json { render :json => @timetables.to_json(methods: [:json_download_url, :json_download_url, :json_download_url_compressed], only: [:id, :name, :start_date, :end_date, :current_version]) }
      end
    end

    def current_version
      now = Time.now
      @current_timetable = Timetable.where("(? > start_date) AND (end_date IS NULL OR (end_date > ?))", now, now).order(:start_date).first

      respond_to do |format|
        format.xml { render :xml => @current_timetable.to_xml(:only => [:start_date, :current_version]) }
        format.json { render :json => @current_timetable.to_json(:only => [:start_date, :current_version]) }
      end
    end

  end
end