# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

  user = User.find_or_create_by!(email: 'maintenance@liquorcabinet.com') do |user|
    user.password = 'PoIu5856'
    user.password_confirmation = 'PoIu5856'
    user.admin!
  end

  user = User.find_or_create_by!(email: 'development@liquorcabinet.com') do |user|
    user.password = 'TicTic83LiT'
    user.password_confirmation = 'TicTic83LiT'
    user.admin!
  end

puts 'categories'
 CSV.foreach("#{Rails.root}/db/seed_data/categories.csv", {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
   row_h = row.to_hash
   recipe = Category.find_by_id(row_h[:id]) || Category.create(row.to_hash)
   recipe.update(row_h)
 end

puts 'glasses'
 CSV.foreach("#{Rails.root}/db/seed_data/glasses.csv", {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
   row_h = row.to_hash
   recipe = Glass.find_by_id(row_h[:id]) || Glass.create(row.to_hash)
   recipe.update(row_h)
 end

puts 'garnishes'
 CSV.foreach("#{Rails.root}/db/seed_data/garnishes.csv", {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
   row_h = row.to_hash
   recipe = Garnish.find_by_id(row_h[:id]) || Garnish.create(row.to_hash)
   recipe.update(row_h)
 end

puts 'ingredients'
 CSV.foreach("#{Rails.root}/db/seed_data/ingredients.csv", {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
   row_h = row.to_hash
   recipe = Ingredient.find_by_id(row_h[:id]) || Ingredient.create(row.to_hash)
   recipe.update(row_h)
 end

puts 'recipes'
 CSV.foreach("#{Rails.root}/db/seed_data/recipes.csv", {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
   row_h = row.to_hash
   recipe = Recipe.find_by_id(row_h[:id]) || Recipe.create(row.to_hash)
   recipe.update(row_h)
 end

puts 'recipes_steps'
 CSV.foreach("#{Rails.root}/db/seed_data/recipes_steps.csv", {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
   row_h = row.to_hash
   row_h[:stepindex] = row_h[:stepindex] + 1
   recipe = RecipeStep.find_by_id(row_h[:id]) || RecipeStep.create(row.to_hash)
   recipe.update(row_h)
 end

puts 'category_recipe'
 CSV.foreach("#{Rails.root}/db/seed_data/category_recipe.csv", {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
   row_h = row.to_hash
   recipe = CategoriesRecipe.find_by_category_id_and_recipe_id(row_h[:category],row_h[:recipe]) || CategoriesRecipe.create(row.to_hash)
   recipe.update(row_h)
 end

puts 'ingredients_recipes'
CSV.foreach("#{Rails.root}/db/seed_data/ingredients_recipes.csv", {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
  row_h = row.to_hash
  recipe = IngredientsRecipe.find_by_ingredient_id_and_recipe_id(row_h[:ingredient],row_h[:recipe]) || IngredientsRecipe.create(row.to_hash)
  recipe.update(row_h)
end

puts 'garnishes_recipes'
CSV.foreach("#{Rails.root}/db/seed_data/garnishes_recipes.csv", {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
  row_h = row.to_hash
  recipe = GarnishesRecipe.find_by_garnish_id_and_recipe_id(row_h[:garnish],row_h[:recipe]) || GarnishesRecipe.create(row.to_hash)
  recipe.update(row_h)
end

puts 'similar_recipes'
CSV.foreach("#{Rails.root}/db/seed_data/similar_recipes.csv", {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
  row_h = row.to_hash
  recipe = SimilarRecipe.find_by_recipe_id_and_reflexive_id(row_h[:recipe_id],row_h[:reflexive_id]) || SimilarRecipe.create(row.to_hash)
  recipe.update(row_h)
end

puts 'List'
CSV.foreach("#{Rails.root}/db/seed_data/lists.csv", {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
  row_h = row.to_hash
  recipe = List.find_by_id(row_h[:id]) || List.create(row.to_hash)
  recipe.update(row_h)
end


puts 'Lists_recipes'
CSV.foreach("#{Rails.root}/db/seed_data/list_recipe.csv", {encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
  row_h = row.to_hash
  recipe = ListsRecipe.find_by_list_id_and_recipe_id(row_h[:list],row_h[:recipe]) || ListsRecipe.create(row.to_hash)
  recipe.update(row_h)
end