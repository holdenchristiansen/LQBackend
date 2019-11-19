json.array!(@recipes) do |recipe|
  json.extract! recipe, :id, :alcoholic, :drinkid, :edited, :favorite, :issuggested, :glass, :information, :instructions, :name, :notes
  json.url recipe_url(recipe, format: :json)
end
