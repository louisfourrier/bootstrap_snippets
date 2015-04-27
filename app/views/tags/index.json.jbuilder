json.array!(@tags) do |tag|
  json.extract! tag, :id, :name, :image_url, :first_letter, :research_name, :slug
  json.url tag_url(tag, format: :json)
end
