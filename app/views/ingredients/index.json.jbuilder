json.array!(@ingredients) do |ingredient|
  json.extract! ingredient, :id, :scratchedoffshoppingcart, :shoppingcart, :name, :optionalassetname, :secondaryname, :type, :cabinet
  json.url ingredient_url(ingredient, format: :json)
end
