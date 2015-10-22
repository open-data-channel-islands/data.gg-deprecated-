ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def get_api_path(category, action, api_version, format)
    "/api/#{api_version}/#{category}/#{action}.#{format}"
  end

  def file_vs_response_json(action, file)
    get action, format: :json
    assert_response :success
    response_json = JSON.parse(response.body)
    file_json = JSON.parse(File.read(file))
    assert response_json == file_json, 'Response JSON does not match file JSON'
  end

  def file_vs_response_xml(action, file)
    get action, format: :xml
    assert_response :success
    response_xml = response.body
    file_xml = JSON.parse(File.read(file)).to_xml
    assert response_xml == file_xml, 'Response XML does not match file XML'
  end
end
