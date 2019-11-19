json.array!(@glasses) do |glass|
  json.extract! glass, :id, :name
  json.url glass_url(glass, format: :json)
end
