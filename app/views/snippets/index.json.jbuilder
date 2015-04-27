json.array!(@snippets) do |snippet|
  json.extract! snippet, :id, :title, :slug, :image_url, :original_url, :html_content, :html_code, :css_code, :js_code, :description, :user_id
  json.url snippet_url(snippet, format: :json)
end
