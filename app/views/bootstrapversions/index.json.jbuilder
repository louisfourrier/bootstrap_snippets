json.array!(@bootstrapversions) do |bootstrapversion|
  json.extract! bootstrapversion, :id, :name, :url_name
  json.url bootstrapversion_url(bootstrapversion, format: :json)
end
