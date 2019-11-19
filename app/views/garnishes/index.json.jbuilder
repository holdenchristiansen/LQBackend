json.array!(@garnishes) do |garnish|
  json.extract! garnish, :id, :name
  json.url garnish_url(garnish, format: :json)
end
