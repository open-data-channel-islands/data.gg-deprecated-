json.array!(@stop_link_exceptions) do |stop_link_exception|
  json.extract! stop_link_exception, :id, :name, :colour
  json.url stop_link_exception_url(stop_link_exception, format: :json)
end
